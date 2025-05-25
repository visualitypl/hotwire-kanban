#!/bin/bash

. .env

set -euo pipefail


# Create a storage bucket for media files
gcloud storage buckets create gs://${PROJECT_ID}-${MEDIA_BUCKET_SUFFIX} \
    --location="$REGION"
gcloud storage buckets add-iam-policy-binding gs://${PROJECT_ID}-${MEDIA_BUCKET_SUFFIX} \
    --member=allUsers --role=roles/storage.objectViewer
