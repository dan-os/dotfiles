# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# update existing `sudo` timestamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
# Possible values: `WhenScrolling`, `Automatic` and `Always`

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Use AirDrop over every interface
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Always open everything in Finder's list view
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Always open Finder in home directory
defaults write com.apple.finder NewWindowTarget PfHm
defaults write com.apple.finder NewWindowTargetPath file:///Users/dan/

# Show hidden .files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Set the Finder prefs for showing a few different volumes on the Desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Dock preferences
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock orientation left
defaults write com.apple.dock show-recents -bool false

# lock screen in bottom-right hot corner
defaults write com.apple.dock wvous-br-corner -int 13
defaults write com.apple.dock wvous-br-modifier -int 0

