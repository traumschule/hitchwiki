set -e
cd $(dirname $0)/../public/discourse
bundle exec rails server 2>&1 >> ../../../logs/discourse.log
