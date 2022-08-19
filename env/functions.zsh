function pbd() {
  yarn create next-app $2 --example https://github.com/evanrs/$1 --example-path src
}

#                                                                              #
#    fn. .  .   .     .        .             .                     .           #
#                                                                              #
function gs.() {
  git status .
}
