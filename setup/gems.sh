function install::gem::bundler() {
  gem install bundler
}

function install::required_gems() {
  install::gem::bundler
}

function main() {
  # handled by bundler using gemspec
  install::required_gems
  # run bundler wherever the app is installed
  cd /vulnerable_forum
  bundle install
}

main
