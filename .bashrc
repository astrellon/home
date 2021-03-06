# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

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
color_prompt=yes

newcolour () {
    bold='\[\e[1m\]'
    reset='\[\e[0m\]'
    black='\[\e[30m\]'
    red='\[\e[31m\]'
    green='\[\e[32m\]'
    yellow='\[\e[33m\]'
    blue='\[\e[34m\]'
    purple='\[\e[35m\]'
    cyan='\[\e[36m\]'
    white='\[\e[37m\]'

    colours[0]=${red}
    colours[1]=${green}
    colours[2]=${yellow}
    colours[3]=${blue}
    colours[4]=${purple}
    colours[5]=${cyan}
    rand=`date +%s`
    if [ `uname -o` == "Cygwin" ]
    then
        let "rand %= 7"
        colours[6]=${bold}${black}
    else
        let "rand %= 6"
    fi

    startBracket="["
    endBracket="]"
    leader=`ps -o stat= -p $$`
    # Check if the leader string has a small s character.
    # This means that the session is the session leader.
    # So if it doesn't contain a small s then we are running from
    # within another session (ie vim).
    if ! [[ $leader =~ "s" ]]
    then
        startBracket="<"
        endBracket=">"
    fi

    HH=`hostname`
    uuser="${green}\u"
    uhost="${blue}\h"
    pre="${reset}${bold}${colours[rand]}${startBracket}"
    post="${bold}${colours[rand]} ${endBracket} ${reset}${white}"
    folder="${bold}${white}\w"

    result="${pre}"

    # Let me know when I'm over SSH
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        result="${result} ${uuser} ${uhost}"
    fi

    result="${result}\$(__git_ps1) ${folder}${post}"

    PS1="${result}"
}

if [ "$color_prompt" = yes ]; then
    # Custom bash prompt via kirsle.net/wizards/ps1.html

    newcolour

else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset cforce_color_prompt

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
alias vi='vim'
alias v='vim'
alias c='cd ..'
alias cc='cd ../..'
alias ccc='cd ../../..'
alias cccc='cd ../../../..'
alias ccccc='cd ../../../../..'
alias sapi='sudo apt install'
alias sapu='sudo apt update'
alias sapuu='sudo apt update && sudo apt upgrade'
alias syi='sudo yum install'
alias gca='git commit -a'
alias gpl='git pull'
alias gps='git push'
alias m='make -j 4'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cl='sakura `pwd` & > /dev/null'
alias ed='ed -p:'

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

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Created by `userpath` on 2019-08-22 23:00:33
export PATH="$PATH:/home/alan/.local/bin"
