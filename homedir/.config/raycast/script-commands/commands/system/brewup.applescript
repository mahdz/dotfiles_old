#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Brew Upgrade
# @raycast.mode inline

# Optional parameters:
# @raycast.packageName System
# @raycast.icon 🆕

# Documentation:
# @raycast.description Runs brewup and mas upgrade
# @raycast.author Manny Hernandnez
# @raycast.authorURL github.com/mahdz

tell application "iTerm"
	-- Handles the case where iTerm is running but has no windows
	set createdWindow to false
	if it is running then
		if (count windows) is 0 then
			create window with default profile
			set createdWindow to true
			tell current tab in current window
				launch session
				tell the last session
					delay 1
					write text "brewup"
				end tell
			end tell
		end if
	end if
	if not createdWindow then
		tell current tab in current window
			launch session
			tell the last session
				delay 1
				write text "brewup"
			end tell
		end tell
	end if
	activate
end tell