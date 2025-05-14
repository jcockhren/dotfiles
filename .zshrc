export VISUAL=vim
export EDITOR=vim
export JAVA_HOME="/usr/lib/jvm/java-8-oracle"
export HAXE_HOME="/usr/lib/haxe"
export WORKON_HOME=$HOME/.tools/virtualenv

bindkey -v
source ~/.tools/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.tools/zsh-history-substring-search/zsh-history-substring-search.zsh


autoload -Uz vcs_info

autoload -U colors && colors
autoload -U compinit && zmodload -i zsh/complist
autoload -U edit-command-line && zle -N edit-command-line
autoload -U url-quote-magic && zle -N self-insert url-quote-magic
autoload -U zmv

setopt complete_in_word


setopt pushd_ignore_dups auto_pushd auto_name_dirs auto_cd \
	prompt_subst no_beep multios extended_glob interactive_comments

HISTFILE=~/.zsh_history
HISTSIZE=40960
SAVEHIST=40960
setopt HIST_EXPIRE_DUPS_FIRST

setopt hist_ignore_dups hist_ignore_space hist_reduce_blanks hist_verify \
	hist_expire_dups_first hist_find_no_dups share_history extended_history \
	append_history inc_append_history nobanghist
setopt prompt_subst

zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "%{$fg[green]%}*"
zstyle ':vcs_info:*' unstagedstr "%{$fg[yellow]%}*"


###############
# Functions
###############

revstring() {
    git rev-parse --short HEAD 2> /dev/null
}

untrackstring() {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        echo ''
    } else {
        echo "%{$fg[red]%}x"
    }
}


precmd() {

    rev=$(revstring)
    untrack=$(untrackstring)
    zstyle ':vcs_info:git*' formats "[%b@$rev%{$reset_color%}] %u%c$untrack"

    vcs_info
}

venv_cd() {
    cd $1
    if [[ -z $(git rev-parse --git-dir 2> /dev/null) ]] || {
       workon $1
    }
}


function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}


gi() {
    gem install $@ --no-ri --no-rdoc;
    rbenv rehash; rehash
}


PROMPT='%{$fg_bold[green]%}$(collapse_pwd) %{$reset_color%}${vcs_info_msg_0_}
$NEWLINE%{$fg[yellow]%{$reset_color%}%}$ '


##############
# Aliases
##############

# Git
alias gst='git status'
alias gci='git commit'
alias gco='git checkout'
alias gbr='git branch'
alias gcl='git clone'
alias gap='git add -p'
alias gl='git log'
alias gll='git lol'
alias gla='git lola'
alias gcia='git commit -a'
alias gm='git merge --no-ff'
alias gd='git diff'
alias gp='git push'
alias gpl='git pull --ff'
alias gf='git fetch'
alias ga='git add'

# cool ones
alias rmr="rm -rf"
alias ls="ls --color"
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -al'
alias df='df -h'
alias ccd="venv_cd"
alias ..='cd ..'

#rbenv
alias rb='rbenv'
alias rg='rbenv gemset'
alias rl='rbenv local'

# fasd
alias v='f -e vi'

# ruby dev
alias be='bundle exec'
alias ber='bundle exec rake'
alias spec='bundle exec rspec'

# AWS
alias aws='aws-mfa aws'

# Tmuxinator
alias tm='tmuxinator'
alias tml='tmuxinator list'
alias tmd='tmuxinator doctor'
alias tms='tmuxinator start'

# Pip
alias pipi='pip install'
alias pipu='pip remove'
alias pipr='pip install -r'

# Pipenv
alias pi='pipenv install'
alias pr='pipenv run'
alias pu='pipenv update'

# Poetry
alias poa='poetry add'
alias por='poetry run'

# Instruqt
alias it='instruqt track'
alias itc='instruqt track create'
alias itd='instruqt track deploy'
alias itl='instruqt track logs'
alias ito='instruqt track open'
alias itp='instruqt track push'
alias itv='instruqt track validate'
alias itpl='instruqt track pull'
alias icc='instruqt challenge create'

# Terraform
alias tf='terraform'

# Vagrant
alias va='vagrant'

# Tailscale
alias ts='tailscale'
alias tss='tailscale status'

##################
# Key Bindings
##################

for keycode in '[' '0'; do
    bindkey "^[${keycode}A" history-substring-search-up
    bindkey "^[${keycode}B" history-substring-search-down
done
unset keycode

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

##################
# Executable Paths
##################

typeset -U path
path+=/usr/local/heroku/bin
path+=$HOME/.rvm/bin
path+=$HOME/.rbenv/bin
path+=/usr/lib/haxe
path+=$HOME/.local/haxe-3.1.3
path+=$HOME/.local/ec2-api-tools-1.6.13.0/bin

path[1,0]=$HOME/.local/bin
path=($^path(N))

export PATH


###############################
# 3rd-party Tool Initialization
###############################

whence -p fasd > /dev/null 2>&1 && eval "$(fasd --init auto) > /dev/null 2>&1"
whence rbenv && eval "$(rbenv init -)"


##################
# GPG Agent w/ SSH
##################

/usr/bin/gpg-agent > /dev/null 2>&1
EXIT=$?
if [ ${EXIT} -ne 0 ]; then
  /bin/rm -f ${HOME}/.gnupg/gpg-agent-info
fi

if [[ $(uname) == Linux ]]; then
  export GPG_TTY=$(tty)
  if [ ! -s "${HOME}/.gnupg/gpg-agent-info" ]; then
    # If we're coming in over ssh, don't prompt with the GUI pinentry
    if [[ -n "$SSH_CONNECTION" ]] ;then
      export PINENTRY_USER_DATA="USE_CURSES=1"
    fi
  fi
  . "${HOME}/.gnupg/gpg-agent-info"

  export GPG_AGENT_INFO
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$PWD/.nvmrc" ] && nvm use  # This loads nvm
