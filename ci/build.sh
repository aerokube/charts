#!/bin/sh

set -e

CHARTS_REPO="https://charts.aerokube.com/"

version=$1
path=${2:-""}
output_dir="output"
if [ -n "$path" ]; then
    output_dir="$output_dir/$path"
    CHARTS_REPO="$CHARTS_REPO$path/"
fi
mkdir -p "$output_dir"
helm package moon --destination "$output_dir" --version "$version"
cd "$output_dir"
wget "$CHARTS_REPO/index.yaml" || true
helm repo index . --url "$CHARTS_REPO" --merge index.yaml
