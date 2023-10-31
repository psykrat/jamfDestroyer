#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root or use sudo."
  exit
fi

launchctl bootout system /Library/LaunchDaemons/com.jamfsoftware.jamf.daemon.plist 2>/dev/null
launchctl disable system/com.jamfsoftware.jamf.daemon 2>/dev/null

rm -rf /usr/local/jamf
rm -rf /usr/local/bin/jamf
rm -rf /Library/Application\ Support/JAMF

rm -f /Library/LaunchDaemons/com.jamfsoftware.*
rm -f /Library/LaunchAgents/com.jamfsoftware.*

pkgutil --pkgs | grep com.jamfsoftware | xargs -I{} sudo pkgutil --forget {} 2>/dev/null

echo "Jamf Pro has been removed. Please reboot the machine for complete cleanup."
