# AWS EKS Production Microservices Platform

## Executive Summary

This project demonstrates the deployment of a production-style containerized application platform using Amazon Elastic Kubernetes Service (EKS).

The solution uses Kubernetes orchestration, Helm package management, AWS managed Kubernetes services, and persistent cloud storage to deploy a scalable application environment.

This project represents a real-world cloud engineering workflow used for running modern applications in production environments.

---

# Project Objectives

This project focuses on:

- Deploying applications using Kubernetes
- Managing container workloads with Amazon EKS
- Implementing scalable cloud infrastructure
- Automating application deployment using Helm
- Managing persistent storage in Kubernetes
- Integrating AWS networking and security services

---

# Architecture Overview

Users

↓

AWS Application Load Balancer

↓

Kubernetes Service

↓

Amazon EKS Cluster

↓

Kubernetes Pods

↓

WordPress Application + MariaDB Database

↓

Amazon EBS Persistent Storage


---

# Technology Stack

## Cloud Platform

- Amazon EKS
- Amazon EC2 Worker Nodes
- Application Load Balancer
- Amazon EBS
- IAM


## Kubernetes

- Kubernetes
- kubectl
- Helm


## Infrastructure Tools

- eksctl
- AWS CLI


## Application

- WordPress
- MariaDB


---

# Infrastructure Design

The Kubernetes environment includes:

- Amazon EKS control plane
- Managed node group
- EC2 worker nodes
- Kubernetes networking
- Application Load Balancer
- Persistent storage


Cluster configuration:

- Node type: t3.medium
- Worker nodes: 2
- Auto scaling enabled
- Region: us-east-1


---

# Deployment Workflow

The deployment process:

1. Install Kubernetes tools

2. Create Amazon EKS cluster

3. Configure IAM OIDC integration

4. Install AWS EBS CSI driver

5. Deploy application using Helm

6. Expose application through Load Balancer

7. Validate Kubernetes workloads


---

# Kubernetes Components

## Pods

Application workloads run inside Kubernetes pods.

## Services

Kubernetes services provide communication and traffic routing.

## Persistent Volumes

Amazon EBS provides persistent storage for stateful applications.

## Helm

Helm manages Kubernetes application deployment and lifecycle.


---

# Storage Architecture

This project uses:

Amazon EBS CSI Driver


Purpose:

- Dynamic volume provisioning
- Persistent application storage
- AWS and Kubernetes storage integration


Storage Class:

gp2


---

# Scaling and Reliability

Implemented:

- Kubernetes self healing
- Container restart capability
- Load balancing
- Node scaling
- Persistent storage


Benefits:

- High availability
- Reliability
- Easier application management


---

# Deployment Commands

Create cluster:

eksctl create cluster


Verify nodes:

kubectl get nodes


Deploy application:

helm install my-wordpress bitnami/wordpress


Check pods:

kubectl get pods


Check service:

kubectl get svc


---

# Security Implementation

Implemented:

- IAM OIDC integration
- AWS IAM permissions
- Kubernetes service accounts
- Secure cloud networking
- Controlled AWS resource access


---

# Engineering Decisions

## Why Amazon EKS?

Amazon EKS provides managed Kubernetes infrastructure while allowing engineers to focus on deploying and operating applications.

## Why Helm?

Helm simplifies Kubernetes application deployment and management.

## Why EBS?

Amazon EBS provides reliable persistent storage for stateful workloads.


---

# DevOps Skills Demonstrated

Cloud Engineering:

- Amazon EKS
- EC2
- IAM
- EBS
- Load Balancing


DevOps:

- Kubernetes
- Helm
- Container Orchestration
- Deployment Automation


Infrastructure:

- Cloud Architecture
- Scalability Design
- Infrastructure Management


---

# Future Improvements

- Add Terraform infrastructure provisioning
- Add Jenkins/GitHub Actions CI/CD pipeline
- Add Prometheus and Grafana monitoring
- Add ArgoCD GitOps deployment
- Add container security scanning


---

# Author

Abdon Njunwa

AWS Certified Solutions Architect

Cloud & DevOps Engineer
