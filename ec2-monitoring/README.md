# 🖥️ EC2 Monitoring with Grafana Cloud

Monitor EC2 instances using Grafana Agent and Node Exporter with Grafana Cloud.

## 🚀 Quick Install

### Option 1: Manual Installation
```bash
# Copy files to EC2 instance
scp grafana-agent.yaml install.sh ec2-user@YOUR_EC2_IP:~

# SSH to instance and run
ssh ec2-user@YOUR_EC2_IP
sudo ./install.sh
```

### Option 2: CloudFormation
```bash
aws cloudformation create-stack \
  --stack-name ec2-monitoring \
  --template-body file://cloudformation-template.yaml \
  --parameters ParameterKey=KeyName,ParameterValue=YOUR_KEY_PAIR \
               ParameterKey=GrafanaCloudURL,ParameterValue=YOUR_GRAFANA_URL \
               ParameterKey=GrafanaCloudUser,ParameterValue=YOUR_USER_ID \
               ParameterKey=GrafanaCloudPassword,ParameterValue=YOUR_API_KEY
```

## 📊 Metrics Collected

- **System metrics**: CPU, memory, disk, network
- **Process metrics**: Running processes, file descriptors
- **Filesystem metrics**: Disk usage, inodes
- **Network metrics**: Interface statistics
- **Custom application metrics** (if configured)

## 🔧 Configuration

1. **Update credentials** in `grafana-agent.yaml`:
   ```yaml
   remote_write:
     - url: YOUR_GRAFANA_CLOUD_PROMETHEUS_URL
       basic_auth:
         username: YOUR_GRAFANA_CLOUD_USER_ID
         password: YOUR_GRAFANA_CLOUD_API_KEY
   ```

2. **Restart services**:
   ```bash
   sudo systemctl restart grafana-agent
   ```

## 📈 Grafana Dashboards

Import these dashboard IDs:
- **1860** - Node Exporter Full
- **11074** - Node Exporter for Prometheus
- **405** - Node Exporter Server Metrics

## 🔍 Troubleshooting

```bash
# Check service status
sudo systemctl status node_exporter
sudo systemctl status grafana-agent

# View logs
sudo journalctl -u grafana-agent -f
sudo journalctl -u node_exporter -f

# Test metrics endpoint
curl http://localhost:9100/metrics
```

## 🏷️ Custom Labels

Add custom labels to identify instances:
```yaml
metrics:
  configs:
    - name: ec2-monitoring
      scrape_configs:
        - job_name: 'node-exporter'
          static_configs:
            - targets: ['localhost:9100']
              labels:
                environment: production
                region: us-east-1
                instance_type: t3.micro
```
