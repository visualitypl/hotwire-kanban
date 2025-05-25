#!/bin/bash

. .env

set -euo pipefail

gcloud config set project $PROJECT_ID

set -x

time gcloud builds submit --config cloudbuild.yaml \
    --substitutions _SERVICE_NAME=$SERVICE_NAME,_INSTANCE_NAME=$INSTANCE_NAME,_REGION=$REGION,_SECRET_NAME=$RAILS_SECRET_NAME
