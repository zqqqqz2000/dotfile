# Dependencies: `fd`, `bat, `rg`, `tree`.


export-env {
  $env.FZF_DEFAULT_COMMAND = "fd --type file --hidden"
}

# History
const ctrl_r = {
  name: history_menu
  modifier: control
  keycode: char_r
  mode: [emacs, vi_insert, vi_normal]
  event: [
    {
      send: executehostcommand
      cmd: "
        let result = history
          | get command
          | str replace --all (char newline) ' '
          | to text
          | fzf;
        commandline edit --append $result;
        commandline set-cursor --end
      "
    }
  ]
}

# Files in z
const ctrl_x =  {
    name: fzf_files
    modifier: control
    keycode: char_x
    mode: [emacs, vi_normal, vi_insert]
    event: [
      {
        send: executehostcommand
        cmd: 'cd (zoxide query -l --exclude (pwd) | lines | reverse | str join "\n" | fzf)'
      }
    ]
}

# Update the $env.config
export-env {
  $env.config.keybindings = $env.config.keybindings | append [
    $ctrl_r
    $ctrl_x
  ]
}
