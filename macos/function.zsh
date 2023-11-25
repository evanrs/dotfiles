function noise:on() {
  defaults write com.apple.ComfortSounds "comfortSoundsEnabled" -bool "true"
  launchctl kill SIGHUP gui/501/com.apple.accessibility.heard
}
function noise:off() {
  defaults write com.apple.ComfortSounds "comfortSoundsEnabled" -bool "true"
  launchctl kill SIGHUP gui/501/com.apple.accessibility.heard
}
