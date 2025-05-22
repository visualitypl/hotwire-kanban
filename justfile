
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

refresh:
    #    rails assets:clobber
    rails assets:precompile

download-original:
    git clone https://github.com/visualitypl/hotwire-kanban.git hotwire-kanban-original
