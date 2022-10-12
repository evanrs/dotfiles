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
  zparseopts -- p+:=port -port+:=port

  # note: npm install -g dev-ip
  value=$(dev-ip | sed "s/'/\"/g" | jq ".[0]" | sed "s/\"//g" | sed "s/^/http\:\/\//g")
  if [ -z "$port" ]; then
  else
    value=$(echo $value | sed "s/\$/\:$port[#]/g")
  fi

  echo $value
}
echo ip: $(ip. --port 3000)
echo ip: $(ip. --port 19000)

function ip.web() {
  ip. | xargs -n 1 open -u
}

function ip.ios() {
  ip. | sed "s/\s//g" | sed "s/^/http\:\/\//g" | xargs -n 1 xcrun simctl openurl booted
}
