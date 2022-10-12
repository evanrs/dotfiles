function pbd() {
  yarn create next-app $2 --example https://github.com/evanrs/$1 --example-path src
}

#                                                                              #
#    fn. .  .   .     .        .             .                     .           #
#                                                                              #
function gs.() {
  git status .
}

function ip.() {
  devip=$(pnpm --silent --package=dev-ip dlx dev-ip)
  value=$(echo $devip | sed "s/'/\"/g" | jq ".[0]" | sed "s/\"//g" | sed "s/^/http\:\/\//g")

  zparseopts -- p+:=port -port+:=port
  if [ -z "$port" ]; then
  else
    value=$(echo $value | sed "s/\$/\:$port[#]/g")
  fi

  echo $value
}

function ip.web() {
  ip. $@ | xargs -n 1 open -u
}

function ip.ios() {
  ip. $@ | xargs -n 1 xcrun simctl openurl booted
}
