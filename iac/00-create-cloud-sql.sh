#!/bin/bash

. .env

set -euo pipefail
# Check if REGION is set
# if [ -z "${REGION:-}" ]; then
#     echo "REGION is not set. Please set it in the .env file."
#     exit 1
# fi
echo "Creating Cloud SQL instance in region $REGION..."
echo "Using these docs: https://cloud.google.com/ruby/rails/run#automation-with-cloudbuild"

gcloud config set project $PROJECT_ID

verde already done -- gcloud sql instances create $CLOUDSQL_INSTANCE_NAME \
    --database-version POSTGRES_12 \
    --tier db-f1-micro \
    --region $REGION

gcloud sql databases create $CLOUDSQL_DATABASE_NAME \
    --instance $CLOUDSQL_INSTANCE_NAME

# CLOUDSQL_DATABASE_PWD
gcloud sql users create "$CLOUDSQL_DATABASE_USERNAME" \
    --instance="$CLOUDSQL_INSTANCE_NAME" --password="$CLOUDSQL_DATABASE_PWD"

# useless for Cloud Run - he creates it for you.
gcloud artifacts repositories create cloud-run-source-deploy \
    --repository-format docker \
    --location "$REGION"
