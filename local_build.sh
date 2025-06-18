#! /bin/bash

docker buildx create --use --name docking-station-builder || docker buildx use docking-station-builder
docker buildx inspect --bootstrap

REPO=ghcr.io/ofirl/docking-station  # Replace accordingly
VERSION=$1                         # Replace with your actual version/tag
TAGS="\
  --tag $REPO:$VERSION"
  # --tag $REPO:1.2"                    # Add more tags if needed
LABELS="\
  --label org.opencontainers.image.version=$VERSION"

ghcr-login

docker buildx build . \
  --file Dockerfile.deploy \
  --platform linux/amd64,linux/arm64 \
  $TAGS \
  $LABELS \
  --build-arg VERSION=$VERSION \
  --push