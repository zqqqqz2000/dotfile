def ensure_py_env [] {
  let venv_paths = fd -t dir -H -I venv | lines
  print venv_paths
  print pwd
  if ($venv_paths | length) == 0 {
    return (-1)
  }
  let script_path = (pwd)/($venv_paths | first)bin/activate.nu

  print $"activate ($script_path)"
  let load = $"overlay use ($script_path)\n"
  $load + '"" | save -f /tmp/python-env.env

  def inside [any_list: list<string>] {
    let outer_in = $in
    $any_list | any { |each| $each == $outer_in }
  }
  for $row in (env | lines | split column --number 2 "=") {
    let key = $row.column1
    let value = $row.column2
    # Exclude certain internal Nushell environment variables if desired
    if (
      $key | inside [PATH VIRTUAL_ENV_DISABLE_PROMPT PROMPT_COMMAND VIRTUAL_ENV VIRTUAL_ENV_PROMPT]
    ) {
        # Handle values that might contain spaces or special characters by quoting them
        let line = $"($key)=($value)\n"
        $line | save --append /tmp/python-env.env
    }
  }
  ' | save -rf "/tmp/python-overlay.nu"
  nu /tmp/python-overlay.nu
}

export alias pd = overlay hide python-layer

export-env {
  if ((ensure_py_env) != -1 and ("/tmp/python-env.env" | path exists)) {
    open /tmp/python-env.env | lines | split column --number 2 "=" | reduce -f {} {|it, acc| 
      $acc | merge {($it.column1):($it.column2)}
    } | load-env
    { PROMPT_INDICATOR: "(venv)"}
  } else {
    print $"cannot find any of env"
    error make {msg: "cannot find any of env"}
  }
}
