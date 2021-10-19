tap 'homebrew/bundle'
tap 'homebrew/core'
tap 'homebrew/services'

# Essential
brew 'zsh'
brew 'rsync'

# GNU core utilities (those that come with OS X are outdated)
brew 'coreutils'
brew 'moreutils'

# GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew 'findutils'

# GNU `sed`, overwriting the built-in `sed`
brew 'gnu-sed'
brew 'rename'
brew 'libevent'


# ASDF dependencies
brew 'coreutils'
brew 'automake'
brew 'autoconf'
brew 'openssl'
brew 'libyaml'
# brew 'readline'
# brew 'libxslt'
brew 'libtool'
brew 'unixodbc'
# brew 'unzip'
# brew 'curl'
brew 'gnupg' # verifies authenticity of plugin
