source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.2"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use sqlite3 as the database for Active Record
gem "sqlite3", ">= 2.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

gem "bootstrap", "~> 5.3.5"
gem "sassc-rails", "~> 2.1.2"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# For drag & drop
gem "acts_as_list"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false
  gem "rspec-rails", "~> 8.0.0"
  gem "factory_bot_rails", "~> 6.4"

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

# postgresql - copiato da https://github.com/chap/rails-8-beta1/blob/main/Gemfile
# fails dockerization, dont know why!!!
gem "pg", "~> 1.1"


# 73.52 An error occurred while installing pg (1.5.9), and Bundler cannot continue.
# 73.52
# 73.52 In Gemfile:
# 73.52   pg
# ------
# Dockerfile:43
# --------------------
#   42 |     COPY Gemfile Gemfile.lock ./
#   43 | >>> RUN bundle install && \
#   44 | >>>     rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
#   45 | >>>     bundle exec bootsnap precompile --gemfile
#   46 |
# --------------------
# ERROR: failed to solve: process "/bin/sh -c bundle install &&     rm -rf ~/.bundle/ \"${BUNDLE_PATH}\"/ruby/*/cache \"${BUNDLE_PATH}\"/ruby/*/bundler/gems/*/.git &&     bundle exec bootsnap precompile --gemfile" did not complete successfully: exit code: 5
# 3408  /usr/bin/dockerd
