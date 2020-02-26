# Set apps to show function keys
defaults write com.apple.touchbar.agent PresentationModePerApp -dict-add "com.citrix.XenAppViewer" functionKeys

# Allow simulator in full screen
defaults write com.apple.iphonesimulator AllowFullscreenMode -bool YES
