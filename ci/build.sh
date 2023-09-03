#!/bin/bash

set -e

CHARTS_REPO="https://charts.aerokube.com/"

commit=$1
path=${2:-""}
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
wget "$CHARTS_REPO/index.yaml" || true
helm repo index . --url "$CHARTS_REPO" --merge index.yaml
