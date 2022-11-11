# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
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

export LOCAL_BIN_PATH=~/.local/bin

export P4_BIN_PATH=~/bin
export P4_LIB_PATH=~/lib

export CUDA_BIN_PATH=/usr/local/cuda/bin
export CUDA_LIB_PATH=/usr/local/cuda/lib64

export NVHPC_BIN_PATH=/opt/nvidia/hpc_sdk/Linux_x86_64/22.7/compilers/bin
export NVHPC_LIB_PATH=/opt/nvidia/hpc_sdk/Linux_x86_64/22.7/compilers/lib

#export PGI_BIN_PATH=/opt/pgi/linux86-64/2017/bin
#export PGI_LIB_PATH=/opt/pgi/linux86-64/2017/lib
export PGI_BASE_PATH=/home/jhoberock/Desktop/pgi/nightly/200430/hpc_sdk/Linux_x86_64/20XX-dev
export PGI_BIN_PATH=$PGI_BASE_PATH/bin
export PGI_LIB_PATH=$PGI_BASE_PATH/lib

export OPENSHMEM_BIN_PATH=/home/jhoberock/dev/openshmem-root/bin

export PATH=$PATH:$LOCAL_BIN_PATH:$CUDA_BIN_PATH:$P4_BIN_PATH:$PGI_BIN_PATH:$OPENSHMEM_BIN_PATH:$NVHPC_BIN_PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_LIB_PATH:$P4_LIB_PATH:$PGI_LIB_PATH:$NVHPC_LIB_PATH

export THRUST_PATH=~/dev/git/thrust-tot
export AGENCY_PATH=~/dev/git/agency-tot

export ICC_PATH=/opt/intel
export ICC_BIN_PATH=$ICC_PATH/bin
export PATH=$PATH:$ICC_BIN_PATH

export TBB2018_PATH=/opt/intel/tbb
export TBB2018_LIB_PATH=$TBB2018_PATH/lib/intel64/gcc4.7
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$TBB2018_LIB_PATH

case `uname` in
  *Darwin*) STARSHIP_OS="";;
  *Linux*)  STARSHIP_OS="";;
  *)        STARSHIP_OS="";;
esac

export STARSHIP_OS
export STARSHIP_CONFIG=~/dev/git/dotfiles/.config/starship.toml
eval "$(starship init bash)"


