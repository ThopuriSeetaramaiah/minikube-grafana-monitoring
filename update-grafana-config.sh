#!/bin/bash
# Replace these with your actual Grafana Cloud values from the connection page
GRAFANA_URL="PASTE_YOUR_REMOTE_WRITE_URL_HERE"
GRAFANA_USER="PASTE_YOUR_USERNAME_HERE"  
GRAFANA_KEY="PASTE_YOUR_API_KEY_HERE"

kubectl patch configmap prometheus-config -n monitoring --patch "
data:
  prometheus.yml: |
    global:
      scrape_interval: 15s
    remote_write:
      - url: $GRAFANA_URL
        basic_auth:
          username: $GRAFANA_USER
          password: $GRAFANA_KEY
    scrape_configs:
      - job_name: 'kubernetes-nodes'
        kubernetes_sd_configs:
          - role: node
      - job_name: 'kubernetes-pods'
        kubernetes_sd_configs:
          - role: pod
"

kubectl rollout restart deployment/prometheus -n monitoring
