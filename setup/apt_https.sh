function install::apt::https_support() {
  sudo apt-get install -y apt-transport-https ca-certificates
}

function install::tree() {
  sudo apt install tree -y
}


function main() {
  install::apt::https_support
  install::tree
}

main
