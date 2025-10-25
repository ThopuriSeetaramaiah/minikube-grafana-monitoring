# 🚀 EKS Monitoring with Grafana Cloud

Monitor Amazon EKS clusters using Grafana Cloud free tier.

## Prerequisites

- EKS cluster running
- kubectl configured: `aws eks update-kubeconfig --name YOUR_CLUSTER_NAME`
- Grafana Cloud account with Prometheus endpoint

## Quick Deploy

1. **Update credentials** in `prometheus-config.yaml`
2. **Run deployment:**
   ```bash
   ./deploy.sh
   ```

## Manual Steps

```bash
kubectl create namespace monitoring
kubectl apply -f prometheus-rbac.yaml
kubectl apply -f prometheus-config.yaml
```

## Grafana Dashboards

Import these dashboard IDs:
- **315** - Kubernetes cluster monitoring
- **8588** - Kubernetes deployment
- **6417** - Kubernetes overview  
- **3119** - EKS cluster monitoring

## Monitoring Features

- ✅ Node metrics (CPU, memory, disk)
- ✅ Pod resource usage
- ✅ Service discovery
- ✅ Ingress monitoring
- ✅ EKS-specific metrics
- ✅ Auto-scaling metrics

## Troubleshooting

```bash
# Check deployment
kubectl get pods -n monitoring

# View logs
kubectl logs -n monitoring deployment/prometheus

# Port forward for local access
kubectl port-forward -n monitoring deployment/prometheus 9090:9090
```
