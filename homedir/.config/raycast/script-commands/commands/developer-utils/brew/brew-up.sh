#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Brew Up
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🍺
# @raycast.packageName Brew

# Documentation:
# @raycast.description brew update => brew upgrade => brew cleanup => brew doctor
# @raycast.author Manny Hernandez

# Light blue looks good with my current colorscheme
TEXTCOLOR='\033[1;34m'

# Update homebrew, and local base of available packages and versions
printf "${TEXTCOLOR}Updating homebrew and local base of available packages and
versions...\n \n"
brew update

# Install new versions of outdated packages
printf "${TEXTCOLOR}Upgrading outdated homebrew packages...\n \n"
brew upgrade

# Check for Mac App Store updates
printf "${TEXTCOLOR}Checking for Mac App Store updates...\n \n"
mas outdated

# Install new versions of outdated Mac App Store apps
printf "${TEXTCOLOR}Upgrading outdated Mac App Store apps...\n \n"
mas upgrade

# Cache cleanup of unfinished downloads
printf "${TEXTCOLOR}Cleaning cache of unfinished downloads...\n \n"
brew cleanup

# Show problems if any
printf "${TEXTCOLOR}Checking for issues...\n \n"
brew doctor