#!/bin/bash

function check_tool() {
  if [ ! hash "$1" 2>/dev/null ]; then
    printf "Error. Required $1 tool is missing.\n"
    printf "Please make sure that $1 is installed prior to running this script.\n"
    printf "Aborting.\n"
    exit 1
  else
    printf "$1 exists. [OK]\n"
  fi
}


# Fails gracefully if vim, curl or git is not installed yet on the machine:
printf "%s\n" "-> Checking the environment..."
check_tool vim
check_tool curl
check_tool git
printf "%s\n" "-> Environment is sane."

# Downloads and installs the pathogen tool by Tim Pope:
printf "%s\n" "-> Installing pathogen... "
mkdir -p ~/.vim/autoload ~/.vim/bundle
if [ -f $HOME/.vim/autoload/pathogen.vim ]; then
  printf "%s\n" "...already installed."
else
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
  printf "%s\n" "...done."
fi

# Downloads and installs the airline plugin:
printf "%s\n" "-> Installing airline..."
if [ -d "$HOME/.vim/bundle/vim-airline" ]; then
  printf "%s\n" "...already installed."
else
  git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
  printf "%s\n" "...done."
fi

# Downloads and installs the vim-better-whitespace plugin:
printf "%s\n" "-> Installing vim-better-whitespace... "
if [ -d "$HOME/.vim/bundle/vim-better-whitespace" ]; then
  printf "%s\n" "...already installed."
else
  git clone git://github.com/ntpeters/vim-better-whitespace.git ~/.vim/bundle/vim-better-whitespace
  printf "%s\n" "...done."
fi

# Finally copies the .vimrc file to the HOME directory:
printf "%s\n" "-> Updating the .vimrc file..."
if [ -f ../.vimrc ]; then
  cp ../.vimrc $HOME
  printf "%s\n" "...updated the .vimrc file"
else
  printf "%s\n" "...warning: Could not locate the .vimrc file to be applied."
fi
