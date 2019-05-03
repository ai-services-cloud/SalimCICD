#!/usr/bin/env bash

set -o errexit
set -o nounset

# default values
export DRONE_DEPLOY_TO=${DRONE_DEPLOY_TO:?'[error] Please specify which cluster to deploy to.'}
export KUBE_NAMESPACE=${KUBE_NAMESPACE=dacc-infra}
export KUBE_CERTIFICATE_AUTHORITY=https://raw.githubusercontent.com/UKHomeOffice/acp-ca/master/${DRONE_DEPLOY_TO}.crt

export NAME="salim"

case ${DRONE_DEPLOY_TO} in
  'acp-notprod')
    export KUBE_SERVER="https://kube-api-notprod.notprod.acp.homeoffice.gov.uk"
    export KUBE_TOKEN=${KUBE_TOKEN_ACP_NOTPROD}
    ;;
esac

echo "--- kube api url: ${KUBE_SERVER}"
echo "--- namespace: ${KUBE_NAMESPACE}"

echo "--- deploying hello world application"
if ! kd --timeout=5m \
  -f kube/example-networkpolicy.yaml \
  -f kube/example-service.yaml \
  -f kube/example-deployment.yaml \
  -f kube/example-ingress.yaml; then
  echo "[error] failed to deploy hello world application"
  exit 1
fi
