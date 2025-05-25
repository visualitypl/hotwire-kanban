#!/bin/bash

. .env

set -euo pipefail

gcloud config set project $PROJECT_ID

set -x

RAILS_ENV=production rails assets:precompile


DATABASE_URL=$DATABASE_URL RAILS_ENV=production \
    bin/dev -p 8080
