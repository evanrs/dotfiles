cask_args appdir: '/Applications'

tap 'homebrew/bundle'
tap 'homebrew/core'
tap 'homebrew/services'
tap 'caskroom/fonts'


# A simple command line interface for the Mac App Store
brew 'mas'


# Security
cask 'keybase'
mas '1Password', id: 443987910


# Essential
brew 'zsh'

# GNU core utilities (those that come with OS X are outdated)
brew 'coreutils'
brew 'moreutils'

# GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew 'findutils'

# GNU `sed`, overwriting the built-in `sed`
brew 'gnu-sed', args: ['--with-default-names']
brew 'rename'
brew 'libevent'


# very essential
cask 'spotify'


# Version control
brew 'git'
brew 'git-lfs'
brew 'hub' # github cli


# Languages
cask 'java'
brew 'drip'
brew 'scala'
brew 'boot-clj'
brew 'leiningen'

brew 'elixir'
brew 'erlang'

brew 'go'

brew 'lua'

brew 'python'
brew 'python3'


# Version management
brew 'rbenv'
brew 'nvm'


# Database and database adjacent …
brew 'redis', restart_service: :changed
brew 'rabbitmq', restart_service: :changed
brew 'datomic'
brew 'sqlite'
brew 'postgresql', restart_service: :changed
brew 'mongodb', restart_service: :changed
brew 'neo4j', restart_service: :changed
brew 'rethinkdb', restart_service: :changed

# Browsers
cask 'firefox'
cask 'google-chrome'
cask 'google-chrome-canary'
cask 'safari-technology-preview'

# Network
brew 'httpie'
brew 'mtr' # traceroute and ping in a single tool
brew 'wget'
brew 'wifi-password' # get the current wifi-password
brew 'wrk'
cask 'charles'
cask 'tunnelbear' # free tunnel
cask 'ngrok'
cask 'postman'

# Development
brew 'carthage'
brew 'watchman'
cask 'iterm2'
cask 'hyper'
cask 'expo-xde'

# Terminal
brew 'thefuck' # corrects your previous console command
brew 'tree' # display directories as trees

# Orchestration
# Virtualization
cask 'virtualbox'
cask 'virtualbox-extension-pack'
cask 'docker'
cask 'vagrant'
brew 'kubernetes'
cask 'minikube'
brew 'kubeless'
brew 'helm'
brew 'terraform'
brew 'ansible'
# Deployment
cask 'now'
brew 'awscli'
brew 's3cmd'
cask 'google-cloud-sdk'


# Editors
brew 'emacs'
brew 'macvim'
brew 'tmux'
cask 'atom'
cask 'sublime-text'
cask 'visual-studio-code'


# Fonts
cask 'font-fira-code'


# Design
cask 'sketch'
cask 'sketch-toolbox'
mas 'Pixelmator', id: 407963104


# Utility
brew 'aspell'
cask 'kaleidoscope' # compare files
mas 'The Unarchiver', id: 425424353


# Workflow
mas 'Moom', id: 419330170
mas 'Clear', id: 504544917
mas 'Timecop', id: 466285239


# Media processing
brew 'pngquant'
brew 'imagemagick'
brew 'ffmpeg'
brew 'libvorbis'
brew 'ffmpeg2theora'
brew 'gifsicle'
brew 'lame'
brew 'x264'
brew 'xvid'
cask 'gifrocket'


# Consumption
cask 'vlc'
mas 'Kindle', id: 405399194


# Collaboration
cask 'slack'


# Amusement
brew 'fortune'
brew 'ponysay'
brew 'lynx'
cask 'geekbench'
