#env bash

#------------------------------------------------------------------------------
# This script prepares .dotfiles for the normal Linux machine:
#  * vim 
#  * .bashrc   - TBD
#  * .screenrc - TBD
#
#  * TODO: Add profiles for home and for work
#------------------------------------------------------------------------------

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"


#------------------------------------------------------------------------------
# NeoVim
#------------------------------------------------------------------------------
function install_nvim() {
  if [ "$(hash nvim 2>/dev/null && echo true)" != "true" ]
  then
    echo "NeoVim not installed, skipped."
    return
  fi
  echo "========================================================================="
  echo " *** Installing NeoVim files *** "
  echo "========================================================================="
  rm -rf ~/.config/nvim
  mkdir -p ~/.config/nvim/bundle
  mkdir -p ~/.config/nvim/backup
  mkdir -p ~/.config/nvim/swp
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  ln -s ${SCRIPTPATH}/init.vim ~/.config/nvim/init.vim
  nvim +PlugInstall +qall
  echo "========================================================================="
  echo " *** NeoVim files installed *** "
  echo "========================================================================="
}

#------------------------------------------------------------------------------
# .bashrc .screenrc etc 
#------------------------------------------------------------------------------
function install_shell() {
  # TODO link for screenrc
  cp .screenrc ~/.
  cat .bashrc >> ~/.bashrc
}

#------------------------------------------------------------------------------
# Call functions to install components
#------------------------------------------------------------------------------
install_nvim
#install_shell
