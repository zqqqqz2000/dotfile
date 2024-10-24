# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Standard plugins can be found in $ZSH/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)
plugins+=(zsh-vi-mode)
if type thefuck >/dev/null 2>&1; then
  plugins+=(thefuck)
fi
plugins+=(tmuxinator)
plugins+=(extract)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx

export EDITOR='nvim'
export ZVM_VI_EDITOR='nvim'

export AIO_FEATURE_VERSION=1.3.2

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias q="exit"
alias c="clear"
alias rescreen="xrandr --auto"
alias work="cd ~/Documents/projects/"
alias pd="deactivate"
alias pa=". ./venv/bin/activate"
alias pcd="conda deactivate"
alias penv="python -m venv venv"
alias e="nvim ."
alias t="tmux -2"

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
  printf %s "${CUTBUFFER}" | xclip -sel c
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

