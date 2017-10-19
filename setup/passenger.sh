function install::passenger::pgp_key() { 
  sudo apt-get install -y dirmngr gnupg
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
}

function install::passenger::apt_repo() {
  sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger xenial main > /etc/apt/sources.list.d/passenger.list'
  sudo apt-get update  
}

function install::passenger::command() {
  sudo apt-get install -y nginx-extras passenger
}

function main() {
  install::passenger::pgp_key
  install::passenger::apt_repo
  install::passenger::command
}

main
