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

## Verification

The complete pipeline has been verified in AWS:

- Jenkins checked out the repository, validated the application, built the image, and pushed versioned images to Amazon ECR.
- Jenkins deployed the image to k3s and confirmed the Kubernetes rollout.
- The `delivery-api` pod is running and the `/health` endpoint returns `{"status":"ok"}`.
- The application is available through Traefik at the EC2 public HTTP endpoint while the lab host is running.

## Status

Completed and verified as a portfolio lab. Destroy the Terraform-managed resources when the demonstration is no longer needed to avoid AWS charges.
