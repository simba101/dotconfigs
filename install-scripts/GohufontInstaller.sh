#!/bin/bash

DOWNLOAD_DIRECTORY=/tmp/gohu
ARCHIVE_NAME="gohufont-2.0.tar.gz"
GOHU_SOURCE="http://font.gohu.org/$ARCHIVE_NAME"
PIXELFONT_BLOCKER="/etc/fonts/conf.d/70-no-bitmaps.conf"
PIXELFONT_ENABLER="/etc/fonts/conf.avail/70-force-bitmaps.conf"

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

# exits gracefully if the script is run by an unprivileged user:
if [[ $EUID -ne 0 ]]; then
  printf "Error. Modifying /etc/fonts requires super-user privileges.\n"
  printf "Please execute this script as root.\n"
  printf "Aborting.\n"
  exit 2
fi
  
# Exits gracefully if tar, gunzip or wget tool have not been installed:
printf "Checking the environment...\n"
check_tool tar
check_tool gunzip
check_tool wget
printf "%s\n" "-> Environment is sane, proceeding to download..."

# Downloads the gohu font:
mkdir -p $DOWNLOAD_DIRECTORY
cd $DOWNLOAD_DIRECTORY
printf "%s\n" "-> Downloading the gohu font..."
wget -q $GOHU_SOURCE

# Extracts it from the archive:
printf "%s\n" "-> Extracting font from the archive..."
tar -zxf $ARCHIVE_NAME
cd gohufont-2.0
gunzip -f *.gz

# Moves the font files:
printf "%s\n" "-> Installing the font..."
mkdir -p $HOME/.fonts
mv $DOWNLOAD_DIRECTORY/gohufont-2.0/*.pcf $HOME/.fonts
fc-cache -f

# Enables the bitmap fonts:
printf "%s\n" "-> Enabling the bitmap fonts..."
if [ -e $PIXELFONT_BLOCKER ] || [ -L $PIXELFONT_BLOCKER ] ; then
  rm $PIXELFONT_BLOCKER
fi
if [ ! -e $PIXELFONT_ENABLER ]; then
  ln -s $PIXELFONT_ENABLER /etc/fonts/conf.d
fi

rm -rf $DOWNLOAD_DIRECTORY
printf "Done. Please restart X.\n"
