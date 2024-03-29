# begin: dotfiles --------------------------------------------------------------------

if [ "$PS1" ]; then
  username_color="\033[38;5;10m"
  at_color="\033[38;5;208m"
  hostname_color="\033[38;5;140m"
  directory_color="\033[38;5;74m"
  #brackets_color="\033[38;5;7m"
  brackets_color=$at_color
  bold="$(tput bold)$brackets_color"
  reset="$(tput sgr0)"
  PS1="\[${bold}\][\[${reset}\]"
  PS1+="\[${username_color}\]\u\[${reset}\]"
  PS1+="\[${at_color}\]@\[${reset}\]"
  PS1+="\[${hostname_color}\]\h\[${reset}\]"
  PS1+="\[${bold}\] > \[${reset}\]"
  PS1+="\[${directory_color}\]\W\[${reset}\]"
  PS1+="\[${bold}\]]\[${reset}\]\\$ "
  export PS1
fi

export EDITOR=nvim
alias vi=nvim
alias vim=nvim

export LS_COLORS=$(cat ~/.ls_colors)

# end: dotfiles --------------------------------------------------------------------
