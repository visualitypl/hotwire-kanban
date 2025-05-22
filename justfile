
list:
    just -l


init:
    echo possibly install ruby: rbenv install 3.3.3
    bundle install
    rails db:setup

run:
    echo "Running rails server..."
    # bundle exec rails server
    bin/dev
