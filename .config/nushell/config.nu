# config.nu
#
# Installed by:
# version = "0.107.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R
#
def install-all-plugins [] {
  let config_path = ($nu.config-path | path dirname) + "/plugins.nuon"

  if not ($config_path | path exists) {
    print $"插件列表配置文件未找到: ($config_path)"
    return
  }

  let plugin_list: list<string> = (open $config_path).plugins

  for plugin in $plugin_list {
      plugin add $plugin
  }
}

alias q = exit
alias c = clear
alias lk = hyprlock
alias work = cd ~/Documents/projects/
alias pa = overlay use -r ~/.config/nushell/python-layer.nu
alias e = nvim
alias t = zellij
alias ct = zellij delete-all-sessions
alias lg = lazygit
alias ww = ^watch -n 1
alias y = yazi

def uiopen [path_or_name: string = "."] {
  use std
  job spawn {
    nohup nemo $path_or_name o+e> (std null-device)
  }
}

$env.config.buffer_editor = "nvim"
$env.config.edit_mode = "vi"
$env.config.cursor_shape = {
  vi_insert: line,
  vi_normal: block
}
$env.config.show_banner = false

oh-my-posh init nu
source ~/.zoxide.nu
