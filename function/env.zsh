function create-secret() {
    secret=$(openssl rand -base64 ${1:-64})
    secret=$(echo $secret | tr -d '\n\r')
    echo $secret
}

function www() {
  open "https://$@"
}

function get-date () {
  echo $(gdate ${1:+"-d $1"})
}

alias whitespace="sed 's/ /·/g;s/\t/￫/g;s/\r/§/g;s/$/¶/g'"
