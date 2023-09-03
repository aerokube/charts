#!/bin/bash

for package in moon moon2 browser-ops license-ops boot; do
  helm lint "$package"
done
