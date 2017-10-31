# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Add path of coreutils symbolic link
export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH

# Add rbenv path
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Add nodebrew path
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$HOME/.composer/vendor/bin:$PATH

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

export LESSCHARSET=utf-8

export EDITOR=vim

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"
#ZSH_THEME="dallas_custom"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git)
plugins=(git ruby osx bundler brew rails emoji-clock)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vi=vim
alias find=gfind
alias xargs=gxargs
# ghq list to peco
alias gh='cd $(ghq list -p | peco)'

alias ctags="`brew --prefix`/user/local/bin/ctags"
alias gtags="gtags --gtagslabel=pygments"

alias gco="git checkout"
alias be="bundle exec"
alias dk="docker"

#pecoでhistory検索
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# peco find directory
function peco-find() {
  local current_buffer=$BUFFER
  local search_root=""
  local file_path=""

  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    search_root=`git rev-parse --show-toplevel`
  else
    search_root=`pwd`
  fi
  file_path="$(find ${search_root} -maxdepth 5 | peco)"
  BUFFER="${current_buffer} ${file_path}"
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-find
bindkey '^]' peco-find

# ghq list to peco
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^l' peco-src

# git branch peco
function peco-git-recent-branches () {
    local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads | \
        perl -pne 's{^refs/heads/}{}' | \
        peco)
    if [ -n "$selected_branch" ]; then
        BUFFER="gco ${selected_branch}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-git-recent-branches
bindkey "^R^B" peco-git-recent-branches


# hub settings
function git(){hub "$@"}

# pepabo-docker-swarm
function swarm() {
  export DOCKER_HOST="tcp://docker.pepabo.com:3376"
  export DOCKER_CERT_PATH="$HOME/.ghq/git.pepabo.com/tech/docker-chef/client_keys"
  export DOCKER_API_VERSION=1.23
  export DOCKER_TLS_VERIFY="1"
}
function dfm() {
  unset DOCKER_HOST
  unset DOCKER_CERT_PATH
  unset DOCKER_API_VERSION
  unset DOCKER_TLS_VERIFY
}
