#!/bin/bash


cd "$(dirname "$0")"

IMAGE_NAME=confluence
VERSION=$(cat Dockerfile | grep "ENV CONFLUENCE_VERSION" | cut -d " " -f 3)
GITHUB_REPOSITORY_OWNER=stratavo

docker build . --file Dockerfile --tag $IMAGE_NAME
docker build . --file Dockerfile-okta --tag $IMAGE_NAME-okta

IMAGE_ID=ghcr.io/$GITHUB_REPOSITORY_OWNER/$IMAGE_NAME
docker tag $IMAGE_NAME $IMAGE_ID:$VERSION
docker push $IMAGE_ID:$VERSION


IMAGE_ID=ghcr.io/$GITHUB_REPOSITORY_OWNER/$IMAGE_NAME-okta
docker tag $IMAGE_NAME-okta $IMAGE_ID:$VERSION
docker push $IMAGE_ID:$VERSION
