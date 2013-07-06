export WORKON_HOME=$HOME/.tools/virtualenv
export PATH="$HOME/.local/bin:/usr/local/bin:/opt/e17/bin:$PATH"
export PYTHONPATH="/opt/e17/lib/python2.7/site-packages:$PYTHONPATH"
export LD_LIBRARY_PATH="/opt/lib64:/opt/e17/lib:$LD_LIBRARY_PATH"
export PROJECT_HOME=$HOME/atiba/sources/django
export VISUAL=vim
source /usr/local/bin/virtualenvwrapper.sh
#source /home/jurnell/.pythonbrew/etc/bashrc

#source /home/jurnell/.rvm/scripts/rvm
bindkey -v
source ~/.tools/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.tools/zshuery/zshuery.sh
load_defaults
load_completion ~/.tools/zshuery/completion
load_correction

setopt prompt_subst

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "%{$fg[green]%}*"
zstyle ':vcs_info:*' unstagedstr "%{$fg[yellow]%}*"


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

PROMPT=' %{$fg_bold[green]%}$(COLLAPSED_DIR)%{$reset_color%} ${vcs_info_msg_0_}
%{$fg[yellow]%}$(prompt_char)%{$reset_color%} ' 
RPROMPT='%{$fg[red]%}$(rvm current)%{$reset_color%}'
source ~/.tools/zsh-history-substring-search/zsh-history-substring-search.zsh
#local s=$(tmux has-session -t main 2>/dev/null)
#[[ $s != "" ]] || {
#	tmux new-session -d -s main \; splitw -d -h \; send htop enter \; selectp -R \; splitw -d \; send "ssh thoth@zawty" enter \; send "htop" enter \; selectp -D \; send "ssh thoth@zawty" enter \; new-window -t main -n thoth \; splitw -d -h \; splitw \; selectp -R \; splitw \; prev \;  attach -t main
#}

#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

eval "$(fasd --init auto)"

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

# cool ones
alias rmr="rm -rf"
alias ls="ls --color"
alias ll='ls -l'
alias la='ls -a'
alias df='df -h'

alias rdk="rvm use ruby-1.9.3@developingkids"

# fasd
alias v='f -e vi'

for keycode in '[' '0'; do
    bindkey "^[${keycode}A" history-substring-search-up
    bindkey "^[${keycode}B" history-substring-search-down
done
unset keycode

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
