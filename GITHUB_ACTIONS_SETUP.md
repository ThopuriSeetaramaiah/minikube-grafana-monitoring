# 🚀 GitHub Actions Setup Guide

Automated deployment pipelines for monitoring stack across environments.

## 🔐 Required Secrets

### Repository Secrets
Go to **Settings** → **Secrets and variables** → **Actions**

#### Grafana Cloud (Required for all environments)
```
GRAFANA_PROMETHEUS_URL=your_grafana_prometheus_endpoint
GRAFANA_USER_ID=your_grafana_user_id
GRAFANA_API_KEY=your_grafana_api_key
```

#### AWS (Required for EKS/EC2)
```
AWS_ACCESS_KEY_ID=your_access_key
AWS_SECRET_ACCESS_KEY=your_secret_key
```

### Environment Variables
Go to **Settings** → **Environments** → Create environments: `dev`, `staging`, `prod`

#### For each environment, add variables:
```
AWS_REGION=us-east-1
EKS_CLUSTER_NAME=your-cluster-name
EC2_KEY_PAIR=your-key-pair-name
```

## 🔄 Workflow Triggers

### 1. Manual Deployment
- **Trigger**: Actions tab → "Deploy Monitoring Stack" → Run workflow
- **Options**: Choose environment and platform

### 2. Automatic Deployment
- **Push to main** → EKS staging, EC2 prod
- **Push to develop** → Minikube dev
- **Path changes** → Deploy specific platform

## 🎯 Deployment Matrix

| Branch | Environment | Platform | Auto Deploy |
|--------|-------------|----------|-------------|
| develop | dev | Minikube | ✅ |
| main | staging | EKS | ✅ |
| main | prod | EC2 | ✅ |
| feature/* | dev | Minikube | Manual |

## 🚀 Usage Examples

### Deploy to Development
```bash
git checkout develop
git push origin develop
# → Automatically deploys Minikube monitoring to dev
```

### Manual Deployment
1. Go to **Actions** tab
2. Select **"Deploy Monitoring Stack"**
3. Choose environment and platform
4. Click **"Run workflow"**

## 📊 Pipeline Features

- ✅ **Multi-Environment Support** (dev/staging/prod)
- ✅ **Platform Detection** (Minikube/EKS/EC2)
- ✅ **Automated Testing** and health checks
- ✅ **Security** with environment-specific secrets
- ✅ **Cleanup Workflows** for resource management

## 🔍 Troubleshooting

### Common Issues
1. **Missing Secrets** - Verify all required secrets are set
2. **AWS Permissions** - Ensure IAM user has proper permissions
3. **Kubernetes Access** - Check cluster accessibility

### Debug Commands
```bash
# Test deployment status
gh run list

# View workflow logs
gh run view <run-id> --log

# Check resources
kubectl get pods -n monitoring
```

Your monitoring infrastructure is now fully automated! 🎉
