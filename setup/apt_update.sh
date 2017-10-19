function install::apt::update() {
  sudo apt-get update -y
}

function main() {
  install::apt::update
}

main
