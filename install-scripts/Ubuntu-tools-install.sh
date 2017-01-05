#!/bin/bash

LOGFILE=/tmp/Ubuntu_postinstall_logs

function get_version()
{
  local VERSION=$($1 --version 2>&1 | head -n 1)
  printf "$VERSION\n"
}

function install()
{
  printf "  -> $1 "
  if type "$1" >/dev/null 2>&1; then
    VERSION=$(get_version $1)
    printf "is already installed [%s]\n" "$VERSION"
  else
    printf "not detected, installing... "
    sudo apt-get --assume-yes install "$1" >>$LOGFILE 2>&1
    VERSION=$(get_version $1)
    printf "done [%s].\n" "$VERSION"
  fi

  # preserves sudo password (+5 minutes by default):
  sudo -v
}

# Checks if sudo exists, fails gracefully if it does not:
type sudo >/dev/null 2>&1 || {
  printf "Error. Please install sudo first.\nExiting.\n"
  exit 1
}

# Fails gracefully if the script is run by root
# (it should be executed by an unprivileged user):
if [[ $EUID -eq 0 ]]; then
  printf "Error. This script must not be run by root.\n"
  printf "Please run this script as an unprivileged user.\nExiting.\n"
  exit 1
fi

printf "Ubuntu postinstall script has been started on `date`\n\n\n" > "$LOGFILE"

# Prints out as root to assert that super-user's rights are granted:
printf "Assuring that sudo is usable...\n"
sudo printf "  -> done.\n"

printf "\nInstalling the basic system tools.\n"
install guake
install thunar
install tilda
install vim

# Installs the developers' tools:
printf "\nInstalling the developers' tools.\n"
install git
install python-pip

# Installs the multimedia-related tools:
printf "\nInstalling the multimedia-related tools.\n"
install audacity
install ffmpeg
install gimp
install inkscape
install mpd
install ncmpcpp
install mpc
install vlc
install youtube-dl

# Installs the internet-related tools:
printf "\nInstalling the network tools.\n"
install thunderbird

# Installs other tools:
# don't install default-jdk

# Informs the user that the installation has been completed successfully:
printf "\n=== Finished installing the basic system ===\n"
printf "Quitting.\n"
exit 0
