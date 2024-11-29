export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:alpha:lib:git' async-prompt no
ZSH_THEME="robbyrussell"

[[ ! -d ~/.zplug ]] && curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
source ~/.zplug/init.zsh

zplug "jeffreytse/zsh-vi-mode"
zplug "plugins/git",   from:oh-my-zsh
zplug "plugins/extract",   from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

source $ZSH/oh-my-zsh.sh

zvm_after_init_commands+=('source <(fzf --zsh)')

export LANG=en_US.UTF-8
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx

export EDITOR='nvim'
export ZVM_VI_EDITOR='nvim'

export AIO_FEATURE_VERSION=1.3.2

alias q="exit"
alias c="clear"
alias rescreen="xrandr --auto"
alias work="cd ~/Documents/projects/"
alias pd="deactivate"
alias pa=". ./venv/bin/activate"
alias pcd="conda deactivate"
alias penv="python -m venv venv"
alias e="nvim ."
alias t="zellij"

alias "??"="gh copilot explain --"
alias "???"="copilot_suggest"

function open() {
  nohup $(echo nemo $1) >/dev/null 2>&1 & 
}

function copilot_suggest() {
  first_arg=$1
  shift
  gh copilot suggest -t $first_arg -- $@
}

# define for zsh vim plugin copy osc52
function zvm_vi_yank () {
	zvm_yank
  BUF64=$(echo -n "${CUTBUFFER}" | base64)
  OSC52="'\e]52;c;${BUF64}\e\\'"
  echo -e -n ${OSC52}
	zvm_exit_visual_mode
}

function exit_if_in_devcontainer ()
{
  if [[ -f "/workspace" ]]; then
    exit 1
  else
    echo "Not in devcontainer"
  fi
}

export PATH="/opt/cuda/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.cargo/bin/:$PATH"

alias denv="~/.devcontainer_env.sh"
alias da="devpod-cli up --ide none . && echo 'Switching into devcontainer' && devpod-cli ssh ."
alias dra='devpod-cli down . && devpod-cli delete . && devpod-cli up --ide none --recreate . && devpod-cli ssh .'
alias ddd="exit_if_in_devcontainer"

if type zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# load all profiles
ZDOTDIR="${ZDOTDIR:-$HOME/.zsh_profiles}"
if [[ -d "$ZDOTDIR" ]]; then
  for file in "$ZDOTDIR"/*.zsh; do
    source "$file"
  done
fi

