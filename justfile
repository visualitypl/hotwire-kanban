
list:
    just -l


init:
    echo possibly install ruby: rbenv install 3.3.3
    bundle install
    rails db:setup

run:
    echo "Running rails server..."
    # bundle exec rails server
    bin/dev -p 3001

refresh:
    rails assets:clobber
    rm -rf tmp/cache/assets
    rails assets:precompile

refresh-and-run:
    just refresh
    just run

download-original:
    git clone https://github.com/visualitypl/hotwire-kanban.git hotwire-kanban-original



# builds locally
docker-build-locally:
    time docker build -f Dockerfile -t hotwire_kanban .

# runs locally
docker-run-locally:
    # docker run -it --rm -p 3001:3000 -v $(pwd):/app hotwire-kanban
    docker run -d -p 80:80 -e RAILS_MASTER_KEY=$(cat config/master.key) --name hotwire_kanban hotwire_kanban
