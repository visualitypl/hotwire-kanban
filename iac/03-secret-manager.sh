#!/bin/bash

. .env

set -euo pipefail

gcloud config set project $PROJECT_ID

bin/rails credentials:edit
