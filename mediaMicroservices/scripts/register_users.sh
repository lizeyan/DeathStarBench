#!/usr/bin/env bash
cluster_ip=$(kubectl -n media-microsvc get svc nginx-web-server -o json | jq -r ".spec.clusterIP")
for i in {1..1000}; do
  curl -d "first_name=first_name_"$i"&last_name=last_name_"$i"&username=username_"$i"&password=password_"$i \
      http://${cluster_ip}:8080/wrk2-api/user/register
done