# AWS DevOps Delivery Platform

An end-to-end DevOps project that provisions AWS infrastructure with Terraform, configures the host with Ansible, and deploys a containerized application through Jenkins to Kubernetes.

## Problem

Manual infrastructure setup and application deployment are inconsistent and difficult to verify. This project creates a repeatable path from cloud infrastructure to a verified application deployment.

## Architecture

```text
GitHub -> Jenkins -> Docker image -> Amazon ECR -> Kubernetes deployment -> rollout verification
             |
             +-> Terraform provisions AWS networking and EC2
             +-> Ansible configures Docker, Jenkins, and k3s on EC2
```

## Technology

- AWS: VPC, subnet, internet gateway, security groups, EC2, ECR
- Terraform: infrastructure provisioning
- Ansible: server configuration
- Jenkins: CI/CD automation
- Docker and k3s: application packaging and deployment

## Repository layout

```text
terraform/   AWS infrastructure
ansible/     repeatable host configuration
app/         Flask health API
kubernetes/  deployment and service manifests
Jenkinsfile  build, ECR push, k3s deployment, rollout check
```

## Status

Infrastructure is provisioned and the EC2 host is configured with Docker, Jenkins, k3s, Git, AWS CLI, and kubectl. The application container was built and its health endpoint verified locally. The Jenkins pipeline is ready to deploy the application to Amazon ECR and k3s.
