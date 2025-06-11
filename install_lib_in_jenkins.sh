#!/bin/bash
set -e

echo "Updating system packages..."
apt-get update && apt-get install -y \
  curl \
  unzip \
  python3-pip \
  groff \
  less \
  ca-certificates \
  tar \
  gzip \
  gnupg \
  lsb-release \
  software-properties-common

#######################################
# Docker
#######################################
echo "Installing Docker CLI..."
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
  > /etc/apt/sources.list.d/docker.list

apt-get update && apt-get install -y docker-ce-cli

#######################################
# Docker Compose (v2 binary plugin)
#######################################
echo "Installing Docker Compose..."
DOCKER_COMPOSE_VERSION="2.26.1"
mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE_VERSION}/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose

docker compose version

#######################################
# AWS CLI
#######################################
echo "Installing AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -q awscliv2.zip
./aws/install
rm -rf awscliv2.zip aws

#######################################
# kubectl
#######################################
echo "Installing kubectl..."
KUBE_VERSION=$(curl -s https://dl.k8s.io/release/stable.txt)
curl -LO "https://dl.k8s.io/release/${KUBE_VERSION}/bin/linux/amd64/kubectl"
chmod +x kubectl && mv kubectl /usr/local/bin/

#######################################
# eksctl
#######################################
echo "Installing eksctl..."
curl -s --location "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz" | tar xz -C /tmp
mv /tmp/eksctl /usr/local/bin/

#######################################
# Verify tools
#######################################
echo "Verifying installations..."
aws --version
kubectl version --client
eksctl version
docker --version
docker compose version

#######################################
# Optional: Setup kubeconfig
#######################################
if [[ -n "$EKS_CLUSTER_NAME" && -n "$AWS_REGION" ]]; then
  echo " Configuring kubeconfig for EKS cluster: $EKS_CLUSTER_NAME"
  aws eks --region "$AWS_REGION" update-kubeconfig --name "$EKS_CLUSTER_NAME"
  kubectl get nodes || echo "⚠️ kubectl failed: Cluster may not be accessible yet"
fi

echo "All tools installed and ready to use."