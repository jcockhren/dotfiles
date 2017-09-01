export PATH="/usr/lib/haxe:$HOME/.local/haxe-3.1.3:$HOME/.local/ec2-api-tools-1.6.13.0/bin:$HOME/.tools/rbenv/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
export VISUAL=vim
export EDITOR=vim
export JAVA_HOME="/usr/lib/jvm/java-8-oracle"
export HAXE_HOME="/usr/lib/haxe"
#export HAXE_LIBRARY_PATH="$HOME/.local/haxe-3.1.3/std:."
#export HAXE_STD_PATH="$HOME/.local/haxe-3.1.3/std:."

bindkey -v
source ~/.tools/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.tools/zshuery/zshuery.sh
load_defaults
load_completion ~/.tools/zshuery/completion
load_correction

if is_linux; then
    export TERM=linux
    export WORKON_HOME=$HOME/.tools/virtualenv
    #export PYTHONPATH="/opt/e17/lib/python2.7/site-packages:$PYTHONPATH"
    #export LD_LIBRARY_PATH="/opt/lib64:/opt/e17/lib:$LD_LIBRARY_PATH"
    #export PROJECT_HOME=$HOME/atiba/sources/django
    source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
fi

setopt prompt_subst

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "%{$fg[green]%}*"
zstyle ':vcs_info:*' unstagedstr "%{$fg[yellow]%}*"

# Tmuxinator
alias tm='tmuxinator'
alias tml='tmuxinator list'
alias tmd='tmuxinator doctor'
alias tms='tmuxinator start'

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

alias ccd="venv_cd"

function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}


PROMPT=' %{$fg_bold[green]%}$(collapse_pwd)%{$reset_color%} ${vcs_info_msg_0_}
%{$fg[yellow]%}$(prompt_char)%{$reset_color%} ' 
if is_linux; then
    RPROMPT='%{$fg[red]%}$(rbenv version-name)@$(rbenv gemset active)%{$reset_color%}'
else
    RPROMPT=''
fi
source ~/.tools/zsh-history-substring-search/zsh-history-substring-search.zsh
#local s=$(tmux has-session -t main 2>/dev/null)
#[[ $s != "" ]] || {
#	tmux new-session -d -s main \; splitw -d -h \; send htop enter \; selectp -R \; splitw -d \; send "ssh thoth@zawty" enter \; send "htop" enter \; selectp -D \; send "ssh thoth@zawty" enter \; new-window -t main -n thoth \; splitw -d -h \; splitw \; selectp -R \; splitw \; prev \;  attach -t main
#}

#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

eval "$(fasd --init auto)"
eval "$(rbenv init -)"

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
alias df='df -h'

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

# Terraform
alias tf='terraform'

# Vagrant
alias va='vagrant'

for keycode in '[' '0'; do
    bindkey "^[${keycode}A" history-substring-search-up
    bindkey "^[${keycode}B" history-substring-search-down
done
unset keycode

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

gi() {
    gem install $@ --no-ri --no-rdoc;
    rbenv rehash; rehash
}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f /home/jurnell/neptunehealth/google-cloud-sdk/path.zsh.inc ]; then
  source '/home/jurnell/neptunehealth/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /home/jurnell/neptunehealth/google-cloud-sdk/completion.zsh.inc ]; then
  source '/home/jurnell/neptunehealth/google-cloud-sdk/completion.zsh.inc'
fi

/usr/bin/gpg-agent > /dev/null 2>&1
EXIT=$?
if [ ${EXIT} -ne 0 ]; then
  /bin/rm -f ${HOME}/.gnupg/gpg-agent-info
fi

if [[ $(uname) == Linux ]]; then
  if [ ! -s "${HOME}/.gnupg/gpg-agent-info" ]; then
    # If we're coming in over ssh, don't prompt with the GUI pinentry
    export GPG_TTY=$(tty)
    if [[ -n "$SSH_CONNECTION" ]] ;then
      export PINENTRY_USER_DATA="USE_CURSES=1"
    fi
    unset GPG_AGENT_INFO
    /usr/bin/gpg-agent --daemon --enable-ssh-support > ${HOME}/.gnupg/gpg-agent-info
  fi
  . "${HOME}/.gnupg/gpg-agent-info"
  export GPG_TTY=$(tty)
  export GPG_AGENT_INFO
fi
