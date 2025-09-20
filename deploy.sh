#!/bin/bash
set -e

kubectl apply --validate=false -f k8s/deployment.yaml
kubectl apply --validate=false -f k8s/service.yaml
kubectl apply --validate=false -f k8s/ingress.yaml

