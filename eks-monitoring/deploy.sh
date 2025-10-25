#!/bin/bash

# EKS Monitoring Deployment Script

echo "🚀 Deploying EKS monitoring to Grafana Cloud..."

# Check if kubectl is configured for EKS
if ! kubectl cluster-info &> /dev/null; then
    echo "❌ kubectl not configured. Run: aws eks update-kubeconfig --name YOUR_CLUSTER_NAME"
    exit 1
fi

# Create namespace
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -

# Apply RBAC
kubectl apply -f prometheus-rbac.yaml

# Apply Prometheus config
kubectl apply -f prometheus-config.yaml

# Wait for deployment
echo "⏳ Waiting for Prometheus to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/prometheus -n monitoring

echo "✅ EKS monitoring deployed successfully!"
echo "📊 Import these Grafana dashboards:"
echo "   - 315 (Kubernetes cluster)"
echo "   - 8588 (Kubernetes deployment)"
echo "   - 6417 (Kubernetes overview)"
echo "   - 3119 (EKS cluster)"
