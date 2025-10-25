# 🐳 Minikube Monitoring with Grafana Cloud

Monitor Minikube cluster using Prometheus with Grafana Cloud free tier.

## 🚀 Quick Start

1. **Start Minikube**
   ```bash
   minikube start
   minikube addons enable metrics-server
   ```

2. **Deploy Monitoring**
   ```bash
   kubectl create namespace monitoring
   kubectl apply -f prometheus-rbac.yaml
   kubectl apply -f prometheus-config-template.yaml  # Update with your credentials first
   ```

## 📁 Files

- `prometheus-config-template.yaml` - Template config (update with your credentials)
- `prometheus-rbac.yaml` - RBAC permissions for Kubernetes discovery
- `update-grafana-config.sh` - Script to update credentials

## 🔧 Setup Steps

1. **Get Grafana Cloud credentials** from https://grafana.com/products/cloud/
2. **Copy template to actual config:**
   ```bash
   cp prometheus-config-template.yaml prometheus-config.yaml
   ```
3. **Update credentials** in `prometheus-config.yaml`
4. **Deploy:**
   ```bash
   kubectl apply -f prometheus-config.yaml
   ```

## 📊 Grafana Dashboards

Import these dashboard IDs:
- **315** - Kubernetes cluster monitoring
- **8588** - Kubernetes deployment
- **6417** - Kubernetes overview

## 🔍 Troubleshooting

```bash
# Check pods
kubectl get pods -n monitoring

# View logs
kubectl logs -n monitoring deployment/prometheus

# Port forward
kubectl port-forward -n monitoring deployment/prometheus 9090:9090
```

## 📈 Metrics Collected

- Node metrics (CPU, memory, disk)
- Pod resource usage
- Kubernetes cluster health
- Service discovery metrics
