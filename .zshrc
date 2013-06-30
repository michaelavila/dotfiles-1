#######################
#### Options and loads
#######################
autoload -U colors
colors

setopt prompt_subst
autoload -U promptinit
promptinit

# enable completion
autoload -U compinit
compinit

# VCS prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats "(%{$fg[green]%}%u%c%b%{$reset_color%})"
zstyle ':vcs_info:*' unstagedstr "%{$fg[red]%}"
zstyle ':vcs_info:*' stagedstr "%{$fg[red]%}"
precmd() {
    vcs_info
}

bindkey -e

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

#######################
#### Exports
#######################
export HISTFILE=$HOME/.history
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE

export PATH=/usr/local/sbin:/usr/local/bin:${PATH}

# npm'z
export PATH="/usr/local/share/npm/bin:$PATH"

# add home bin folders to path
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export EDITOR="vi"

# Path to the .zsh directory
export ZSH=$HOME/.zsh

# spelling correction
setopt correct_all

#######################
#### Prompt
#######################
PROMPT_PREFIX="[%{$fg[cyan]%}%*%{$reset_color%}] %{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} %~"
PROMPT_SUFFIX="%(!.#.>)"

PROMPT='$PROMPT_PREFIX ${vcs_info_msg_0_} $PROMPT_SUFFIX '

# Tab and window title
case $TERM in
    *xterm*|ansi)
        function settab { print -Pn "\e]1;%~\a" }
        function settitle { print -Pn "\e]2;%~\a" }
        function chpwd { settab;settitle }
        settab;settitle
    ;;
esac

#######################
#### Aliases
#######################
alias ls='ls -G'
alias ll='ls -lh'

# PostgreSQL
alias start_postgres="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias stop_postgres="pg_ctl -D /usr/local/var/postgres stop -s -m fast"

# IP
alias whats-my-ip="curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+'"

# virtualenv
export WORKON_HOME=$HOME/.virtualenvs
test -d $WORKON_HOME || mkdir $WORKON_HOME
source /usr/local/share/python/virtualenvwrapper_lazy.sh

#######################
#### pip
#######################
# keep all logs in one place
export PIP_LOG_FILE='/tmp/pip-log.txt'
# use a cache
export PIP_DOWNLOAD_CACHE='/tmp/pip_cache'

bindkey '^R' history-incremental-search-backward

# init RVM
PATH=$PATH:$HOME/.rvm/bin
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
