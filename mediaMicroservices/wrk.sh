#!/usr/bin/env bash
cd $(dirname $0)/
cd wrk2
echo CWD=${PWD}
while [ 1 == 1 ]; do
  ./wrk -D exp -t 8 -c 100 -d 1h -L -s ./scripts/media-microservices/compose-review.lua http://$(kubectl -n media-microsvc get svc nginx-web-server -o json | jq -r ".spec.clusterIP"):8080/wrk2-api/review/compose -R 100
done