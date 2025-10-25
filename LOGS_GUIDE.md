# 📋 Logs Collection Guide

Send application logs to Grafana Cloud using Promtail.

## 🚀 Setup

1. **Update Promtail config** with your Grafana Cloud credentials:
   ```bash
   cp minikube-monitoring/promtail-template.yaml minikube-monitoring/promtail-config.yaml
   # Edit promtail-config.yaml with your Loki URL and credentials
   ```

2. **Deploy Promtail**:
   ```bash
   kubectl apply -f minikube-monitoring/promtail-config.yaml
   ```

3. **Deploy log generator**:
   ```bash
   kubectl apply -f minikube-monitoring/log-generator.yaml
   ```

## 📊 View Logs in Grafana Cloud

1. Go to **Explore** → Switch to **Loki** data source
2. Try these queries:
   ```logql
   {namespace="default"}           # All logs
   {app="log-generator"}          # Application logs
   {app="sample-app"}             # Nginx logs
   {app="log-generator"} |= "ERROR"  # Error logs only
   ```

## ⏱️ Timeline
- **1-2 minutes**: Logs appear in Grafana Cloud
- **3-5 minutes**: Full log history available

Your logs will include INFO, DEBUG, WARN, and ERROR messages from the sample applications!
