#env bash

#------------------------------------------------------------------------------
# This script prepares .dotfiles for the normal Linux machine:
#  * vim 
#  * .bashrc   - TBD
#  * .screenrc - TBD
#
#  * TODO: Add profiles for home and for work
#------------------------------------------------------------------------------


#------------------------------------------------------------------------------
# VIM
#------------------------------------------------------------------------------
function install_vim() {
  echo "========================================================================="
  echo " *** Installing Vim files *** "
  echo "========================================================================="
  rm -r ~/.vimrc
  rm -rf ~/.vim
  mkdir -p ~/.vim/bundle
  mkdir -p ~/.vim/backup
  mkdir -p ~/.vim/swp
  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  ln -s ~/dotfiles/.vimrc ~/.vimrc
  vim +BundleInstall +qall 2>&1 > /dev/null
  echo "========================================================================="
  echo " *** Vim files installed *** "
  echo "========================================================================="
}

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
  git clone https://github.com/gmarik/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
  ln -s ~/dotfiles/init.vim ~/.config/nvim/init.vim
  nvim +BundleInstall +qall 2>&1 > /dev/null
  echo "========================================================================="
  echo " *** NeoVim files installed *** "
  echo "========================================================================="
}

#------------------------------------------------------------------------------
# .bashrc .screenrc etc 
#------------------------------------------------------------------------------
function install_shell() {
  cp .screenrc ~/.
  cat .bashrc >> ~/.bashrc
}

#------------------------------------------------------------------------------
# Call functions to install components
#------------------------------------------------------------------------------
#install_vim
install_nvim
install_shell
