#!/bin/bash

# Will also create ~/.config/mpd and ~/.config if needed:
mkdir -p ~/.config/mpd/playlists

# Prompts the user to enter the name of this mpd.conf file:
printf "Please enter the name for the config file (ENTER for mpd.conf): "
read FILE_NAME
if [ -z "$FILE_NAME" ]; then
  FILE_NAME="mpd.conf"
fi

# Holds the full path to the created file:
F="$HOME/.config/mpd/$FILE_NAME"

# Prompts the user to enter the path to his music directory:
printf "Please enter the path to your music directory "
printf "(ENTER for ~/Audio/Music): "
read MUSIC_DIRECTORY
if [ -z "$MUSIC_DIRECTORY" ]; then
  MUSIC_DIRECTORY="~/Audio/Music"
fi

printf "##########################################################\n"    > "$F"
printf "# MPD config file autogenerated by InstallMpdConf script #\n"   >> "$F"
printf "##########################################################\n\n" >> "$F"

printf "# Required files:\n" >> "$F"
printf "db_file            \"~/.config/mpd/database\"\n" >> "$F"
printf "log_file           \"~/.config/mpd/log\"\n\n" >> "$F"
printf "# Optional files/directories:\n" >> "$F"
printf "music_directory    \"$MUSIC_DIRECTORY\"\n" >> "$F"
printf "playlist_directory \"~/.config/mpd/playlists\"\n" >> "$F"
printf "pid_file           \"~/.config/mpd/pid\"\n" >> "$F"
printf "state_file         \"~/.config/mpd/state\"\n" >> "$F"
printf "sticker_file       \"~/.config/mpd/sticker.sql\"\n\n" >> "$F"

printf "##################### AUDIO OUTPUT: ######################\n" >> "$F"
printf "audio_output {\n" >> "$F"
printf "  type         \"alsa\"\n" >> "$F"
printf "  name         \"My ALSA Device\"\n" >> "$F"
printf "}\n" >> "$F"

printf "Finished generating the config. Its contents are:\n"
cat "$F"
printf "Done. Thank you for using the InstallMpdConf script!\n"
