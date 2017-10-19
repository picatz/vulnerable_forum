# Interactive Password Prompts Are Lame
export DEBIAN_FRONTEND=noninteractive

echo "mysql-server-5.7 mysql-server/root_password password root" | sudo debconf-set-selections
echo "mysql-server-5.7 mysql-server/root_password_again password root" | sudo debconf-set-selections

function install::mysql_server() {
  sudo apt-get install mysql-server -y
}

function install::mysql_client() {
  sudo apt-get install mysql-client -y
}

function install::mysql_dev() {
  sudo apt-get install libmysqlclient-dev -y
}

function main() {
  install::mysql_dev
  install::mysql_server
}

main
