__echo=echo

function useMiddleware() {
  method=$1

  function middleware() {
    $method ${@:1}
  }
}
