#!/bin/bash

### AUTO-CONFIG SECTION: extract the necessary directories' names.
# Extracts the full name of the directory containing this script:
SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )"

# Extracts the full name of the root directory of this repo:
ROOT_DIR="$(dirname "$SCRIPTS_DIR")"

# Contains the full name of the directory containing the dotfiles,
# which will be filled later by calling the select_dotfiles_src function:
DOTFILES_DIR=""
### END OF AUTO-CONFIG SECTION.


###############################################################################
# select_dotfiles_src() method
# sets the global variable $DOTFILES_DIR according to the user's preferences.
function select_dotfiles_src()
{
  local AVAILABLE_DOTFILES=("dotfiles_debian" "dotfiles_work")
  printf "Please select the dotfiles source. The following are available:\n"
  PS3="Your choice: "
  local ANS=""
  select ANS in "${AVAILABLE_DOTFILES[@]}"; do
    case "$ANS" in
      # If the user chooses the debian dotfiles:
      "${AVAILABLE_DOTFILES[0]}")
        DOTFILES_DIR="$ROOT_DIR/${AVAILABLE_DOTFILES[0]}"
        printf "Debian dotfiles have been selected.\n"
        break
      ;;

      # If the user chooses the workplace dotfiles:
      "${AVAILABLE_DOTFILES[1]}")
        DOTFILES_DIR="$ROOT_DIR/${AVAILABLE_DOTFILES[1]}"
        printf "Workplace dotfiles have been selected.\n"
        break
      ;;

      *)
        printf "Incorrect dotfiles source.\n"
      ;;
    esac
  done
}

# install_config() method
# invoke with: install_config repo_file target_file
function install_config() {
  # Terminates the entire script if this function has been called
  # with an incorrect number of positional parameters (expects exactly two):
  if [ $# -ne 2 ]; then
    printf "[install_config] ERROR: expected 2 parameters, got $#."
    printf " Exiting.\n"
    exit 3
  fi

  local TARGET=$2
  local SOURCE=$1
  local TARGET_PARENT_DIR="$(dirname "$TARGET")"
  local FILENAME="$(basename "$SOURCE")"

  local ACTIONS=("overwrite local file" "do nothing" "meld files")

  printf "\n -> Installing config: [$FILENAME]\n"

  # If the directory to which a config file should be copied does not exist,
  # it will be created now:
  if [ ! -d "$TARGET_PARENT_DIR" ]; then
    printf "Creating the directory: %s\n" "$TARGET_PARENT_DIR"
    mkdir -p TARGET_PARENT_DIR
  fi

  # Terminates the function if source file is missing:
  if [ ! -f "$SOURCE" ]; then
    printf "Error: Source file %s does not exist, omitting.\n" "$SOURCE"
    return 1
  fi

  # If the target file does not exist, simply copies the source file:
  if [ ! -f "$TARGET" ]; then
    printf "Copying $FILENAME to $TARGET_PARENT_DIR..."
    cp "$SOURCE" "$TARGET" >/dev/null 2>&1
    if [ $? -ne 0]; then
      printf " failed.\n"
      printf "[WARNING] The file has not been copied properly!\n"
    else
      printf " done.\n"
    fi
  # If the target file does exist, however, the user is presented
  # a variety of options to pick one from, and the script behaves accordingly:
  else
    printf "File $FILENAME exists on the machine already.\n"
    printf "Checking for differences..."
    cmp --silent "$SOURCE" "$TARGET" >/dev/null 2>&1
    if [ $? -ne 0 ]; then
      printf " the files differ.\n"
      printf "Please select desired action:\n"
      local ANS=""
      PS3="Your choice: "
      select ANS in "${ACTIONS[@]}"; do
        case "$ANS" in
          # If the user chooses to overwrite a file:
          "${ACTIONS[0]}")
            printf "Overwriting..."
            cp "$SOURCE" "$TARGET" >/dev/null 2>&1
            if [ $? -ne 0 ]; then
              printf " failed.\n"
              printf "[WARNING] The file has not been copied properly!\n"
            else
              printf " done.\n"
            fi
            break
          ;;

          # If the user chooses to do nothing:
          "${ACTIONS[1]}")
            printf "Leaving the file unchanged.\n"
            break
          ;;

          # If the user chooses to meld the files:
          "${ACTIONS[2]}")
            if type "meld" >/dev/null 2>&1; then
              # meld exists and will be used for the two files:
              printf "Melding. Local file will be displayed in the left pane.\n"
              meld $TARGET $SOURCE >/dev/null 2>&1
              break
            else
              printf "[ERROR] meld tool is not installed.\n"
              printf "Please select another action.\n"
            fi
          ;;

          *)
            printf "Incorrect action.\n"
          ;;
        esac
      done
    else
      printf " the files are the same. Nothing more to do.\n"
    fi
  fi
}

# End of install_config() method's definition.
###############################################################################

# Queries the user for the source from which dotfiles should be installed:
select_dotfiles_src

# Installs the shell-related configs:
install_config "$DOTFILES_DIR/common.shrc" "$HOME/.config/common.shrc"
install_config "$DOTFILES_DIR/bashrc" "$HOME/.bashrc"
install_config "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"
install_config "$DOTFILES_DIR/vimrc" "$HOME/.vimrc"
install_config "$DOTFILES_DIR/Xresources" "$HOME/.Xresources"
