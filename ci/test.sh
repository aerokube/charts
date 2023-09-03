#!/bin/bash

for package in moon moon2 browser-ops license-ops; do
  helm lint "$package"
done
