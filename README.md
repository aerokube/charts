# Aerokube Charts Repository

This repository contains source files for Aerokube [Helm](https://helm.sh/) charts.

## Usage

To use a stable chart version:
```
$ helm repo add aerokube https://charts.aerokube.com/
$ helm repo update
$ helm search repo aerokube
$ helm upgrade --install --set=moon.enabled.resources=false service.externalIPs[0]=$(minikube ip) -n moon moon aerokube/moon
```

We are also building and packing an unstable chart version for every commit. To access these charts:
```
$ helm repo add aerokube-unstable https://charts.aerokube.com/unstable/
$ helm repo update
$ helm search repo aerokube-unstable --devel --versions
$ helm upgrade --install --devel -n moon moon aerokube-unstable/moon # --devel flag is required
```
