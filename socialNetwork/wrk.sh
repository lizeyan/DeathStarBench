#!/usr/bin/env bash
cd $(dirname $0)/
cd wrk2
echo CWD=${PWD}
while [ 1 == 1 ]; do
  ./wrk -D exp -t 8 -c 100 -R 10 -d 1h -L -p -s ./scripts/social-network/mixed-workload.lua http://$(kubectl -n social-network get svc nginx-thrift -o json | jq -r ".spec.clusterIP"):8080
done