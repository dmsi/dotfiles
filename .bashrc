#
# begin: dotfiles --------------------------------------------------------------------
#

# For mac
#export PS1="[\[$(tput sgr0)\]\[\033[38;5;10m\]ds\[$(tput sgr0)\]\[\033[38;5;208m\]@\[$(tput sgr0)\]\[\033[38;5;88m\]mac\[$(tput sgr0)\]|\[$(tput sgr0)\]\[\033[38;5;74m\]\W\[$(tput sgr0)\]]\\$ \[$(tput sgr0)\]"

# For dark terminal theme
#export PS1="[\[$(tput sgr0)\]\[\033[38;5;10m\]\u\[$(tput sgr0)\]\[\033[38;5;208m\]@\[$(tput sgr0)\]\[\033[38;5;220m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]|\[$(tput sgr0)\]\[\033[38;5;74m\]\W\[$(tput sgr0)\]\[\033[38;5;15m\]]\\$ \[$(tput sgr0)\]"

# For light terminal theme
#export PS1="[\[$(tput sgr0)\]\[\033[38;5;10m\]\u\[$(tput sgr0)\]\[\033[38;5;208m\]@\[$(tput sgr0)\]\[\033[38;5;88m\]\h\[$(tput sgr0)\]|\[$(tput sgr0)\]\[\033[38;5;74m\]\W\[$(tput sgr0)\]]\\$ \[$(tput sgr0)\]"
if [ "$PS1" ]; then
  export PS1="[\[$(tput sgr0)\]\[\033[38;5;10m\]\u\[$(tput sgr0)\]\[\033[38;5;208m\]@\[$(tput sgr0)\]\[\033[38;5;68m\]\h\[$(tput sgr0)\]|\[$(tput sgr0)\]\[\033[38;5;74m\]\W\[$(tput sgr0)\]]\\$ \[$(tput sgr0)\]"
fi

export EDITOR=nvim
alias vi=nvim
alias vim=nvim

#
# end: dotfiles --------------------------------------------------------------------
#
