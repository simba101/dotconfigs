# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Provides longer scrollback:
HISTSIZE=2048
HISTFILESIZE=4096

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

export TERM=screen-256color

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# added a (nicer) bash prompt from my old Slackware box:
PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'

unset color_prompt force_color_prompt



# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Path to the Scripts directory:
export PATH='/home/a.szczerbiak/Source/Scripts':$PATH

# My own aliases:
alias lss='ls -Al'
alias gr='grep'
alias tasks='leafpad /home/a.szczerbiak/Documents/Tasks &'

# Easy killing:
alias k9='kill -9' 
alias kk='kill -9'

# Easy cd-ing:
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# make apt behave like pacman ;)
alias pacget='sudo apt-get install'
alias pacsearch='apt-cache search'
alias pacupg='sudo apt-get upgrade'

# My own one-letter aliases:
alias b='bc -l'
alias c='clear'
alias e='echo'
alias g='git'
alias m='make'
alias q='exit'
alias t='tmux -2' # tmux: quick start, create new 256-color anonymous session.

# My own typo autocorrections:
alias sl='ls'
alias ls='ls --color=auto'
alias tmux='TERM=xterm-256color tmux'

# Git Amend Date
alias gad='GIT_COMMITER_DATE="`date`" git commit --amend --date="`date`"'

# truly colorful man pages:
man() {
    env LESS_TERMCAP_mb=$(printf "\e[1;31m") \
	LESS_TERMCAP_md=$(printf "\e[1;31m") \
	LESS_TERMCAP_me=$(printf "\e[0m") \
	LESS_TERMCAP_se=$(printf "\e[0m") \
	LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
	LESS_TERMCAP_ue=$(printf "\e[0m") \
	LESS_TERMCAP_us=$(printf "\e[1;32m") \
	man "$@"
}
#

# Find in Random:
alias fr='cat /dev/urandom | hexdump -C | grep --color=auto "ff ff ff"'
alias fra='cat /dev/urandom | hexdump -C | grep --color=auto'

# Export useful IP addresses as global vars:
export TV_L='106.120.57.216'
export TV_C='106.116.153.86'
export TV_R='106.120.57.214'
export PORUCZNIK='106.116.37.23'

# easy SDB shell access for both root and developer accounts:
alias sdbd='sdb root off && sdb shell'
alias sdbr='sdb root on && sdb shell'
alias sdbc='sdb connect'
alias sdbdc='sdb disconnect'

alias tizen_debug_console="google-chrome --no-first-run --activate-on-launch --no-default-browser-check --allow-file-access-from-files --disable-web-security --disable-translate --proxy-auto-detect --proxy-bypass-list=127.0.0.1 --app=http://106.116.153.86:7011/inspector.html?page=1"
# Enable programmable sdb completion features.
if [ -f ~/.sdb/.sdb-completion.bash ]; then
 source ~/.sdb/.sdb-completion.bash
fi
source /home/a.szczerbiak/tizen-sdk/tools/ide/bin/tizen-autocomplete
