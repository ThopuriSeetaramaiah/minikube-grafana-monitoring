# 📊 Kubernetes & AWS Monitoring with Grafana Cloud

Complete monitoring setup for Minikube, EKS, and EC2 using Grafana Cloud free tier.

## 🚀 Quick Start

### Minikube Monitoring
```bash
cd minikube-monitoring
minikube start
minikube addons enable metrics-server
kubectl create namespace monitoring
kubectl apply -f prometheus-rbac.yaml
# Update prometheus-config-template.yaml with your credentials first
kubectl apply -f prometheus-config-template.yaml
```

### EKS Monitoring
```bash
cd eks-monitoring
# Update prometheus-config.yaml with your credentials
./deploy.sh
```

### EC2 Monitoring
```bash
cd ec2-monitoring
# Copy files to EC2 and run
./install.sh
```

## 📁 Project Structure

```
├── README.md                    # This file
├── minikube-monitoring/         # Minikube monitoring setup
│   ├── README.md
│   ├── prometheus-config-template.yaml
│   ├── prometheus-rbac.yaml
│   └── update-grafana-config.sh
├── eks-monitoring/              # EKS monitoring setup
│   ├── README.md
│   ├── prometheus-config.yaml
│   ├── prometheus-rbac.yaml
│   └── deploy.sh
└── ec2-monitoring/              # EC2 monitoring setup
    ├── README.md
    ├── grafana-agent.yaml
    ├── install.sh
    └── cloudformation-template.yaml
```

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
