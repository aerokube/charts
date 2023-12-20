#!/bin/bash

set -e

CHARTS_REPO="https://charts.aerokube.com/"

commit=$1
regenerate=${2:-""}
path=${3:-""}
output_dir="output"
if [ -n "$path" ]; then
    output_dir="$output_dir/$path"
    CHARTS_REPO="$CHARTS_REPO$path/"
fi
mkdir -p "$output_dir"
for package in moon moon2 browser-ops license-ops boot; do
  pushd "$package"
  version=$(yq '.version' Chart.yaml)
  if [ -n "$path" ]; then
    version="$version-$commit"
  fi
  popd
  helm package "$package" --destination "$output_dir" --version "$version"
done
cd "$output_dir"
if [ -n "$regenerate" ] -a [ "$regenerate" = "true" ]; then
  regenerateDir="regenerate"
  mkdir -p "$regenerateDir"
  pushd "$regenerateDir"
  aws s3 cp "s3://$S3_BUCKET_NAME" . --endpoint="$S3_ENDPOINT"
  helm repo index . --url "$CHARTS_REPO"
  popd
  cp regenerate/index.yaml .
  rm -Rf "$regenerateDir"
else
  wget -O index.yaml "$CHARTS_REPO/index.yaml"
fi
helm repo index . --url "$CHARTS_REPO" --merge index.yaml
