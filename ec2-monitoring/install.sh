#!/bin/bash

# EC2 Monitoring Installation Script

echo "🚀 Installing EC2 monitoring for Grafana Cloud..."

# Detect OS
if [[ -f /etc/redhat-release ]]; then
    OS="rhel"
elif [[ -f /etc/debian_version ]]; then
    OS="debian"
else
    echo "❌ Unsupported OS"
    exit 1
fi

# Install Node Exporter
echo "📊 Installing Node Exporter..."
NODE_EXPORTER_VERSION="1.6.1"
wget https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
tar xvfz node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
sudo mv node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64/node_exporter /usr/local/bin/
rm -rf node_exporter-${NODE_EXPORTER_VERSION}*

# Create node_exporter service
sudo tee /etc/systemd/system/node_exporter.service > /dev/null <<EOF
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=nobody
Group=nobody
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

# Install Grafana Agent
echo "🔧 Installing Grafana Agent..."
if [[ "$OS" == "debian" ]]; then
    wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
    echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list
    sudo apt-get update
    sudo apt-get install -y grafana-agent
elif [[ "$OS" == "rhel" ]]; then
    sudo tee /etc/yum.repos.d/grafana.repo > /dev/null <<EOF
[grafana]
name=grafana
baseurl=https://packages.grafana.com/oss/rpm
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://packages.grafana.com/gpg.key
EOF
    sudo yum install -y grafana-agent
fi

# Copy config
sudo cp grafana-agent.yaml /etc/grafana-agent.yaml

# Start services
sudo systemctl daemon-reload
sudo systemctl enable --now node_exporter
sudo systemctl enable --now grafana-agent

echo "✅ EC2 monitoring installed successfully!"
echo "📝 Update /etc/grafana-agent.yaml with your Grafana Cloud credentials"
echo "🔄 Then restart: sudo systemctl restart grafana-agent"
