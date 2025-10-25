# 📊 Minikube Monitoring with Grafana Cloud

Complete setup for monitoring Minikube cluster using Grafana Cloud free tier.

## 🚀 Quick Start

1. **Start Minikube**
   ```bash
   minikube start
   minikube addons enable metrics-server
   ```

2. **Deploy Monitoring Stack**
   ```bash
   kubectl create namespace monitoring
   kubectl apply -f prometheus-rbac.yaml
   kubectl apply -f prometheus-config.yaml
   ```

3. **Access Grafana Cloud**
   - Import dashboards: 315, 8588, 6417
   - View metrics in 5-10 minutes

## 📁 Files

- `prometheus-config.yaml` - Prometheus deployment with Grafana Cloud remote write
- `prometheus-rbac.yaml` - RBAC permissions for Kubernetes discovery
- `update-grafana-config.sh` - Script to update credentials (template)

## 🔧 Configuration

### Grafana Cloud Setup
1. Sign up at https://grafana.com/products/cloud/
2. Get connection details from "Connections" → "Hosted Prometheus"
3. Update `prometheus-config.yaml` with your credentials:
   - Remote Write URL
   - Username/Instance ID
   - API Key

### Kubernetes Dashboards
Import these dashboard IDs in Grafana Cloud:
- **315** - Kubernetes cluster monitoring
- **8588** - Kubernetes deployment
- **6417** - Kubernetes overview

## 📈 Metrics Collected

- **Node metrics**: CPU, memory, disk usage
- **Pod metrics**: Resource consumption, status
- **Cluster health**: API server, etcd, scheduler
- **Application metrics**: From pods with Prometheus annotations

## 🔍 Troubleshooting

**Check Prometheus status:**
```bash
kubectl get pods -n monitoring
kubectl logs -n monitoring deployment/prometheus
```

**Verify metrics flow:**
```bash
kubectl port-forward -n monitoring deployment/prometheus 9090:9090
# Visit http://localhost:9090/targets
```

**Common issues:**
- RBAC permissions: Ensure `prometheus-rbac.yaml` is applied
- Credentials: Verify Grafana Cloud URL, username, and API key
- Network: Check if remote write endpoint is reachable

## 🎯 Free Tier Limits

Grafana Cloud free tier includes:
- 10,000 metrics
- 50GB logs
- 50GB traces
- 14-day retention

Perfect for development and small clusters.

---

*Setup tested on Minikube v1.32.0 with Kubernetes v1.28.3*
