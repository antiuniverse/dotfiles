# System-wide bashrc.
if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi

# If not running interactively, don't do anything more.
[ -z "$PS1" ] && return

# force correct UTF8 characters for e.g. line drawing
export NCURSES_NO_UTF8_ACS=1

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
	source ~/.bash_aliases
fi

# Programmable completion.
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
	source /etc/bash_completion
fi

if [ -n "$(command -v brew)" ]; then
	if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
		source "$(brew --prefix)/etc/bash_completion"
	fi
fi

# dircolors
if [ -r ~/.dircolors ]; then
	if [ -n "$(command -v dircolors)" ]
		then eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	elif [ -n "$(command -v gdircolors)" ]
		then eval "$(gdircolors -b ~/.dircolors)" || eval "$(gdircolors -b)"
	fi
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color) color_prompt=yes;;
	xterm-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
	if [ "$(type -t __git_ps1)" == "function" ]; then
		PS1='${debian_chroot:+($debian_chroot)}\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[35m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '
	else
		PS1='${debian_chroot:+($debian_chroot)}\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[00m\]\$ '
	fi
else
	if [ "$(type -t __git_ps1)" == "function" ]; then
		PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1 " (%s)")\$ '
	else
		PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
	fi
fi

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#	;;
#*)
#	;;
#esac