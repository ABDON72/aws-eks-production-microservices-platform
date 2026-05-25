#!/bin/bash

# Install eksctl
curl --silent --location \
"https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz" \
| tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

# Install Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Create EKS cluster
eksctl create cluster \
  --name abdon-eks-cluster \
  --region us-east-1 \
  --nodegroup-name abdon-nodes \
  --node-type t3.medium \
  --nodes 2 \
  --nodes-min 1 \
  --nodes-max 3 \
  --managed

# Verify nodes
kubectl get nodes

# Add Bitnami Helm repo
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

# Enable OIDC
eksctl utils associate-iam-oidc-provider \
  --region us-east-1 \
  --cluster abdon-eks-cluster \
  --approve

# Add EBS CSI driver
eksctl create addon \
  --name aws-ebs-csi-driver \
  --cluster abdon-eks-cluster \
  --region us-east-1 \
  --force

# Add IAM permissions for EBS
eksctl create iamserviceaccount \
  --name ebs-csi-controller-sa \
  --namespace kube-system \
  --cluster abdon-eks-cluster \
  --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
  --approve \
  --override-existing-serviceaccounts \
  --region us-east-1

# Restart EBS controller
kubectl rollout restart deployment \
  ebs-csi-controller -n kube-system

# Deploy WordPress via Helm
helm install my-wordpress bitnami/wordpress \
  --set wordpressUsername=abdon \
  --set wordpressBlogName="Abdon's Company Website" \
  --set global.storageClass=gp2

# Get pods status
kubectl get pods

# Get Load Balancer URL
kubectl get svc my-wordpress
