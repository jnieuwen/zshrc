# $Id: 10b744a52bc48562a9aac3043833164a9fc2e671 $
# Lines configured by zsh-newuser-install
export PATH

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_PAPER=en_US.UTF-8
export LC_NAME=en_US.UTF-8
export LC_ADDRESS=en_US.UTF-8
export LC_TELEPHONE=en_US.UTF-8
export LC_MEASUREMENT=en_US.UTF-8
export LC_IDENTIFICATION=en_US.UTF-8
export LC_ALL=

# Set the history information.
export HISTFILE=~/.histfile
export HISTSIZE=1000
export SAVEHIST=1000

# Source our default exports and aliasses
# so we do not have to maintain 2 seperate instances.

export PROMPT_COMMAND='echo -n -e "\033k\033\\"'
export EDITOR=vim
export PAGER=/usr/bin/less
bindkey -e

alias cd="cd -P"
alias dirs="dirs -v"
alias steve=jobs

# Make sure we are in our home dir. (Fix apple bug)
cd ~

#-------------------------------------------------------------------------------
# cleanup wrong aliasses
#unalias cd
alias history='history -di'

# Source the colors.
#. /usr/share/zsh/4.2.3/functions/colors
autoload -U colors
colors

autoload -U compinit
compinit

set -o vi

# Umask en limits
umask 0007
ulimit -c 0

LOGCHECK=10
watch=(all)

if [ $TERM=xterm ]
then
	export TERM=xterm-256color
fi

#-------------------------------------------------------------------------------
export PERIOD=180
export DIRSTACKSIZE=7
export WATCHFMT='20%D %T: %n has %a (%M)'
export REPORTTIME=10
export CDPATH=~/cache

# Perl readline library
export PERL_RL=Zoid

#-------------------------------------------------------------------------------
# PROMPTS
export RPROMPT="%D{%H:%M:%S}"
export PS1='(ret: %?) (jobs: %j) ($SHELL) (%4~) (%D{%I:%M %p}) $vcs_info_msg_0_
[%!][%{${fg[blue]}%}%B%n%{${fg[yellow]}%}@%{${fg[green]}%}%m%b%{${fg[default]}%}]%# '

#-------------------------------------------------------------------------------
# The options we want
#setopt menucomplete
setopt CHASE_LINKS
setopt RM_STAR_SILENT
setopt NO_BEEP
setopt PUSHD_IGNORE_DUPS
setopt AUTO_PUSHD
setopt PROMPT_SUBST

#-------------------------------------------------------------------------------
# Completions.

# Usernames

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'


# hosts
jeroen_se_hosts=(hermod)

zstyle ':completion:*' hosts \
	$jeroen_se_hosts

#-------------------------------------------------------------------------------
# Functions we use.

precmd () { vcs_info }

#periodic()
#{
#	source $HOME/.bash/alias
#}

# fasd 
#eval "$(fasd --init auto)"

# Zplug 
#export ZPLUG_HOME=/usr/local/opt/zplug
#source $ZPLUG_HOME/init.zsh

#zplug "wfxr/forgit"
#zplug "wookayin/fzf-fasd"

#zplug load 
