#!/usr/bin/env bash

#local emulation using floci.io
export AWS_ENDPOINT_URL=http://localhost:4566
export AWS_DEFAULT_REGION=us-east-1
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test

EXISTING_CONTAINER_ID=$(docker ps -a --filter "ancestor=floci/floci:latest" --format="{{.ID}}")
if [ -n "$EXISTING_CONTAINER_ID" ]; then
    echo "found running container: $EXISTING_CONTAINER_ID"
    docker rm -f $EXISTING_CONTAINER_ID
    echo "stopped"
else    
    echo "No running containers"
fi

docker run --rm -d -p 4566:4566 \
  floci/floci:latest

aws s3api create-bucket --bucket jitsi-local-tfstate

terraform init -backend-config=backendfiles/backend.dev.conf

