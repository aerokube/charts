# Aerokube Charts Repository

This repository contains source files for Aerokube [Helm] charts.

## Usage

```
$ helm repo add aerokube https://charts.aerokube.com/
$ helm search repo aerokube
$ helm upgrade --install --set=moon.enabled.resources=false service.externalIPs[0]=$(minikube ip) -n moon moon aerokube/moon
```
