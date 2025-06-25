#!/usr/bin/env bash
set -e

VERSIONS=$(ls -d */ | cut -f1 -d'/')
VARIANT=$1
CURRENT_PATH=$(pwd)

for VERSION in $VERSIONS
do
	echo "Processing $VERSION..."
	ABS_VERSION_FOLDER=$CURRENT_PATH/$VERSION
	echo "Going into folder: $ABS_VERSION_FOLDER"
	cd $ABS_VERSION_FOLDER

  apko publish $VARIANT.yaml $DH_ORGANIZATION/$ARTIFACT_NAME-$VERSION-$VARIANT:$TAG --sbom=false \
          --annotations="org.opencontainers.image.title:distroless-$ARTIFACT_NAME" \
          --annotations="org.opencontainers.image.description:Distroless/Hardened $ARTIFACT_NAME Docker image" \
          --annotations="org.opencontainers.image.url:https://github.com/$GH_ORGANIZATION/$GH_REPOSITORY" \
          --annotations="org.opencontainers.image.source:https://github.com/$GH_ORGANIZATION/$GH_REPOSITORY" \
          --annotations="org.opencontainers.image.version:$TAG" \
          --annotations="org.opencontainers.image.created:$(date -u "+%Y-%m-%dT%H:%M:%S%:z")" \
          --annotations="org.opencontainers.image.revision:$(git rev-parse HEAD)"
  echo "...done!"
done