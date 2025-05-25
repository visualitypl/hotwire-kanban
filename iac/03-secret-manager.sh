#!/bin/bash

. .env

set -euo pipefail

gcloud config set project $PROJECT_ID

echo DONE: bin/rails credentials:edit


echo "[public]  RAILS_SECRET_NAME: $RAILS_SECRET_NAME"
echo "[private]  RAILS_MASTER_KEY: $RAILS_MASTER_KEY"

gcloud secrets create "$RAILS_SECRET_NAME" --data-file config/master.key
gcloud secrets describe "$RAILS_SECRET_NAME" # --format="value(name)"

#gcloud projects describe $PROJECT_ID --format='value(projectNumber)'

gcloud secrets add-iam-policy-binding $RAILS_SECRET_NAME \
    --member serviceAccount:${PROJECT_NUMBER}-compute@developer.gserviceaccount.com \
    --role roles/secretmanager.secretAccessor

gcloud secrets add-iam-policy-binding $RAILS_SECRET_NAME \
    --member serviceAccount::${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com \
    --role roles/secretmanager.secretAccessor
