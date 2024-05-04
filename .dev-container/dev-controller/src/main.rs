use clap::{Parser, Subcommand};
use commands::{down, exec_it, run};
use serde_derive::{Deserialize, Serialize};
use std::{
    collections::HashMap,
    env,
    ffi::OsStr,
    fs::{self, OpenOptions},
    io::Write,
    path::Path,
};
mod commands;

/// Simple tool for control dev docker environment
#[derive(Parser, Debug, Clone)]
struct Args {
    /// languages and its version, e.g. --lang python:3.10 --lang golang:2.1
    #[arg(short, long)]
    lang: Vec<String>,
    /// config file for dev-container, default: "dev-container.toml", if empty and not exists, will
    /// create a new one
    #[arg(short, long)]
    config: Option<String>,
    /// the name of container in podman
    #[arg(long = "name", short = 'n')]
    container_name: Option<String>,
    /// the image name, default: "devallinone"
    #[arg(short, long, default_value = "devallinone")]
    image_name: String,
    #[command(subcommand)]
    command: Option<Command>,
}

#[derive(Subcommand, Debug, Clone)]
enum Command {
    Up,
    Down,
    ExecIT,
    Init,
}

#[derive(Deserialize, Serialize)]
struct Config {
    lang: HashMap<String, String>,
    image_name: String,
    container_name: String,
}

impl Config {
    fn default() -> Config {
        let curr_dir = env::current_dir()
            .expect("cannot read current dir")
            .file_name()
            .expect("cannot parse filename, please do not run this in root path")
            .to_str()
            .unwrap()
            .to_string();
        Config {
            lang: HashMap::from([
                ("golang".to_string(), "1.21.4".to_string()),
                ("python".to_string(), "3.11".to_string()),
                ("npm".to_string(), "16.3.0".to_string()),
            ]),
            image_name: "devallinone".to_string(),
            // placeholder for now, will auto generate by path or read from config/args
            container_name: curr_dir,
        }
    }
}

fn parse_args_lang(lang: Vec<String>) -> HashMap<String, String> {
    lang.iter()
        .map(|each| {
            let split_res = each.splitn(2, ':').collect::<Vec<_>>();
            if split_res.len() != 2 {
                panic!("the language should be format: 'lang:version', but got {each}");
            }
            (split_res[0].to_string(), split_res[1].to_string())
        })
        .collect::<HashMap<_, _>>()
}

fn generate_default_config(write_path: &Path, lang_from_args: HashMap<String, String>) {
    if !write_path.exists() {
        let mut default_config = Config::default();
        if !lang_from_args.is_empty() {
            default_config.lang.extend(lang_from_args.clone());
        }
        let default_toml = toml::to_string(&default_config).unwrap();
        let mut file = OpenOptions::new()
            .write(true)
            .create(true)
            .truncate(true)
            .open(write_path)
            .expect("cannot create default config file, name: 'dev-container.toml'");
        file.write_all(
            format!("# devcontainer config for tool `dev-controller` tool\n{default_toml}")
                .as_bytes(),
        )
        .expect("cannot write default config into file");
    };
}

fn load_parse_config(args: Args) -> Config {
    let lang_from_args = parse_args_lang(args.lang);
    let path = match args.config {
        Some(ref p) => Path::new(p),
        None => {
            let default_path = Path::new("dev-container.toml");
            // not exists, then create default
            generate_default_config(&default_path, lang_from_args.clone());
            default_path
        }
    };
    let content = fs::read_to_string(path).unwrap();
    let mut config_from_file: Config = match path
        .extension()
        .and_then(OsStr::to_str)
        .expect("config file should got an ext, e.g. dev-container.toml")
    {
        "toml" => toml::from_str(content.as_str()).expect("cannot parse config file into toml"),
        "json" => {
            serde_json::from_str(content.as_str()).expect("cannot parse config file into json")
        }
        "yaml" | "yml" => {
            serde_yaml::from_str(content.as_str()).expect("cannot parse config file into yaml")
        }
        other => panic!("not support file ext: {other}"),
    };
    // fill default language into parsed config
    let mut lang_default = Config::default().lang;
    lang_default.extend(config_from_file.lang.clone());
    config_from_file.lang = lang_default;

    if !lang_from_args.is_empty() {
        config_from_file.lang.extend(lang_from_args);
    }
    config_from_file
}

fn main() {
    let args = Args::parse();
    let config = load_parse_config(args.clone());
    match args.command {
        None => {
            run(
                config.image_name,
                config.lang,
                config.container_name,
                HashMap::new(),
            );
            exec_it();
        }
        Some(ref cmd) => match cmd {
            Command::Up => run(
                config.image_name,
                config.lang,
                config.container_name,
                HashMap::new(),
            ),
            Command::Down => down(),
            Command::ExecIT => exec_it(),
            Command::Init => {}
        },
    };
}
