# Project 2: Deploying Microservices on Amazon EKS

## Overview
This project demonstrates deploying WordPress 
as a microservice on Amazon EKS (Elastic 
Kubernetes Service) using Helm. This simulates 
a real world enterprise deployment where 
applications are containerized, orchestrated 
by Kubernetes, and exposed via AWS Load Balancer.

## Architecture
- Amazon EKS Cluster (Kubernetes 1.34)
- 2 Worker Nodes (t3.medium) with Auto Scaling
- WordPress 7.0 deployed via Helm
- MariaDB database (persistent storage)
- AWS EBS CSI Driver (gp2 storage class)
- AWS Application Load Balancer

## Real World Use Case
Companies use this setup to:
- Handle millions of users automatically
- Scale up during peak traffic
- Self heal when containers crash
- Deploy updates with zero downtime
- Separate concerns with microservices

## Tools Used
| Tool | Version | Purpose |
|------|---------|---------|
| eksctl | v0.226.0 | Create EKS cluster |
| kubectl | v1.36.1 | Manage Kubernetes |
| Helm | v3.21.0 | Deploy applications |
| AWS EKS | 1.34 | Managed Kubernetes |
| AWS EBS | gp2 | Persistent storage |

## Prerequisites
- AWS CLI configured
- kubectl installed
- eksctl installed
- Helm installed
- IAM permissions for EKS

## Deployment Steps

### 1. Install Required Tools
```bash
# Install eksctl
curl --silent --location \
"https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz" \
| tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

# Install Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

### 2. Create EKS Cluster
```bash
eksctl create cluster \
  --name abdon-eks-cluster \
  --region us-east-1 \
  --nodegroup-name abdon-nodes \
  --node-type t3.medium \
  --nodes 2 \
  --nodes-min 1 \
  --nodes-max 3 \
  --managed
```

### 3. Configure EBS Storage
```bash
eksctl utils associate-iam-oidc-provider \
  --region us-east-1 \
  --cluster abdon-eks-cluster \
  --approve

eksctl create addon \
  --name aws-ebs-csi-driver \
  --cluster abdon-eks-cluster \
  --region us-east-1 \
  --force
```

### 4. Deploy WordPress via Helm
```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install my-wordpress bitnami/wordpress \
  --set wordpressUsername=abdon \
  --set wordpressBlogName="Abdon's Company Website" \
  --set global.storageClass=gp2
```

### 5. Access WordPress
```bash
kubectl get svc my-wordpress
```
Open browser and visit the Load Balancer URL!

## Key Concepts Demonstrated
- Container orchestration with Kubernetes
- Helm package management
- Persistent storage with EBS
- Load balancing with AWS ELB
- IAM roles and OIDC integration
- Auto scaling configuration

## Author
**Abdon Njunwa**
- GitHub: [@ABDON72](https://github.com/ABDON72)
- Certifications: AWS Solutions Architect | CompTIA A+ | CompTIA Security+
