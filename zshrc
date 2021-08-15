# $Id: 10b744a52bc48562a9aac3043833164a9fc2e671 $
# Lines configured by zsh-newuser-install
PATH=/usr/local/bin:/usr/local/sbin:~/bin:/sw/bin:/sw/sbin:~/scripts:$PATH
PATH=/opt/local/bin:/opt/local/sbin:$PATH:/Users/jnieuwen/android-sdk-mac_86/tools
PATH=$PATH:/usr/local/opt/go/libexec/bin:/Users/jnieuwen/.cargo/bin
PATH=$PATH:/Users/jnieuwen/.local/bin
export PATH

# Vi mode timeout.
export KEYTIMEOUT=1

# Zplug 
export ZPLUG_HOME=/usr/local/opt/zplug
# fasd 
eval "$(fasd --init auto)"
alias v='f -e vim'
alias gf-feature-start='git flow feature start'
alias gf-feature-finish='git flow feature finish'
alias gf-release-start='git flow release start'
alias gf-release-finish='git flow release finish'
alias gf-hotfix-start='git flow hotfix start'
alias gf-hotfix-finish='git flow hotfix finish'
alias gf-support-start='git flow support start'
alias gf-support-finish='git flow support finish'
alias gf-push='git push --set-upstream origin'

source $ZPLUG_HOME/init.zsh
#zplug "wfxr/forgit"
#zplug "wookayin/fzf-fasd"

zplug load 


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
export TEXBASE=/usr/local/texlive/2016/texmf-dist/tex/latex
#export TEXINPUTS=$TEXBASE/base/:$TEXBASE/supertabular/:$TEXBASE/graphics/:$TEXBASE/rotating/:$TEXBASE/fancyhdr/:$TEXBASE/ae/:$TEXBASE/subfigure/:$TEXBASE/ntgclass/:$TEXBASE/isodoc:$TEXBASE/latexconfig:$HOME/files/t/templates/:.
#for addit in $TEXBASE/*
#do
#	TEXINPUTS=$TEXINPUTS:$addit
#done
export TEXINPUTS=/usr/local/texlive/2016/texmf-dist/tex//:$HOME/archive/2012-11-pre/t/templates/:.

# Source our default exports and aliasses
# so we do not have to maintain 2 seperate instances.

export PROMPT_COMMAND='echo -n -e "\033k\033\\"'
export EDITOR=vim
export PAGER=/usr/bin/less
bindkey -e

alias cd="cd -P"
alias down="cd $HOME/Downloads"
alias gca='git commit -a'
alias gpom='git push origin master'
alias hermod='ssh hermod'
alias his2sh="fc -l -n -100"
alias in="cd $HOME/inbox/"
alias pd=pushd
alias po=popd
alias puppv='puppet parser validate'
alias r='fc -s'
alias stopisstart='fc -s stop=start'
alias amazon="cd '/Users/jnieuwen/Library/Containers/com.amazon.Kindle/Data/Library/Application Support/Kindle/My Kindle Content'"
alias dirs="dirs -v"
alias steve=jobs
alias fixes='rg "TODO|FIXME"'
alias fetchshell='pushd ~/inbox && scp -r shell:~/inbox/"*" . && ssh shell "cd ~/inbox && rm -rfv *" && popd'
alias standup='jrnl -from "-36 hours"'
alias ls='ls -G'

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

if [ -f $HOME/.ssh_agent.txt ]
then
	source $HOME/.ssh_agent.txt
fi

if [ $TERM=xterm ]
then
	export TERM=xterm-256color
fi

#-------------------------------------------------------------------------------
export PERIOD=180
export DIRSTACKSIZE=7
export WATCHFMT='20%D %T: %n has %a (%M)'
export REPORTTIME=10
#export CDPATH=~/cache

# Perl readline library
export PERL_RL=Zoid

#-------------------------------------------------------------------------------
# PROMPTS
export RPROMPT="%D{%H:%M:%S}"
export PS1='(ret: %?) (jobs: %j) ($SHELL) (%4~) (%D{%I:%M %p}) $vcs_info_msg_0_
[%!][%{${fg[blue]}%}%B%n%{${fg[yellow]}%}@%{${fg[magenta]}%}%m%b%{${fg[default]}%}]%# '

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
zstyle ':completion:*' users jnieuwen root jeroen.van.nieuwenhuizen


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

# jnifunc:
markdown2dokuwiki() { # <file.md> - converts <file>.md to <file>.dokuwiki
	pandoc -f markdown -t dokuwiki -o ${1/.md/.dokuwiki} $1
}

# jnifunc:
markdown2pdf() { # <file.md> -  converts <file>.md to <file>.pdf
	pandoc -f markdown -t latex -o ${1/.md/.pdf} $1
}

# jnifunc:
newses() { # starts a new tmux session
    TMUX=''
    tmux new-session -d -s "$*"
    tmux switch-client -t "$*"
}

# jnifunc:
jnihelp() { # Shows my zsh functions
    grep "jn[i]func:" -A1 $HOME/.zshrc | grep -v "jn[i]func:"
}

# Work in progress directory

# jnifunc:
wip() { # Change to the work in progress directory (subdir)
    cd $HOME/wip/$1
}

_wip_complete() {
    local -a subcmds
    subcmds=($(ls $HOME/wip | sort))
    _describe 'command' subcmds
}
compdef _wip_complete wip

# jnifunc:
activate() { # Activate a given virtual env (~/venv/<venv>)
    source $HOME/venv/$1/bin/activate
}

_activate_complete() {
    local -a subcmds
    subcmds=($(ls $HOME/venv | sort))
    _describe 'command' subcmds
}
compdef _activate_complete activate

_cheat_complete() {
    local -a subcmds
    subcmds=($(find $HOME/.dotfiles/cheat -exec basename {} \; | sort ))
    _describe 'command' subcmds
}
compdef _cheat_complete cheat

# jnifunc:
dailywww() { # Open the webpages I have to review daily
    open "http://grafana.service.dc1.docker.jeroen.se:3000/d/Zf2yXX_mk/my-dashboard?orgId=1&refresh=1m"
    open "http://hrund.jeroen.se:8000"
    open "http://nagios.service.dc1.docker.jeroen.se/nagios/cgi-bin/tac.cgi"
    open "https://www.buienradar.nl/weer/delft/nl/2757345/14daagse"
}

# Include autojump stuff
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh


source $HOME/.poetry/env
source $HOME/.zsh/git_worktree.zsh

if [ -f /Users/jnieuwen/.ghcup/env ]
then
    source /Users/jnieuwen/.ghcup/env
fi

if which starship > /dev/null 2>&1
then
    eval $(starship init zsh)
fi

if [ -f ~/bin/myhis.sh ]
then
    source ~/bin/myhis.sh
fi

eval "$(mcfly init zsh)"
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/bit bit

[ -f ~/.sman/sman.rc ] && source ~/.sman/sman.rc

export PATH=$PATH:~/.sman/bin

alias rnw='tmux rename-window'
alias tks='tmux kill-session -t'
alias cat='bat -p'
alias less='bat -p'
alias grep='rg -N'

source $HOME/bin/stack.sh

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#  export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters

function tempdir() {
    mktemp -d "tmp-${1}-XXXX"
}
