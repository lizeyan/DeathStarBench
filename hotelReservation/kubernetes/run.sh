#!/usr/bin/env bash
action=${1:-apply}
for file in *.yaml; do
  envsubst < ${file} | kubectl --kubeconfig /root/.kube/config ${action} -n hr -f -
done