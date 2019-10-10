function npm-preview() {
  npm pack && tar -xvzf *.tgz && rm -rf package *.tgz
}
