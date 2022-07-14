#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Chrome URL in Safari
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔗
# @raycast.packageName Browsing

# Documentation:
# @raycast.description Opens the current active Chrome tab in Safari
# @raycast.author Manny Hernandez

osascript -e 'tell application "Google Chrome Canary" to get URL of active tab of first window' | pbcopy

regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
pasteboardString=$(pbpaste)

if [[ $pasteboardString =~ $regex ]]
then
    open -a Safari $pasteboardString
else
    echo "String in clipboard is a not valid URL"
fi
