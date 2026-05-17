
# Cloud Resume Challenge — AWS + Terraform + GitHub Actions

## Overview

This project is a fully serverless cloud-native resume application built on AWS and provisioned using Terraform Infrastructure as Code (IaC).

The project evolved from an initially manual AWS implementation into a fully automated infrastructure deployment workflow using Terraform, remote state management, and GitHub Actions CI/CD.

It demonstrates practical experience with:

* Infrastructure as Code (Terraform)
* AWS serverless architecture
* Remote Terraform state management
* CI/CD automation
* GitHub Actions + OIDC federation
* CloudFront CDN delivery
* IAM and security configuration
* Backend API integration
* Infrastructure troubleshooting and debugging

---

## Live Demo

* Website: `https://d326rj5pqilrxa.cloudfront.net'
* API Endpoint: `https://2wro77dhed.execute-api.us-east-1.amazonaws.com'

---

## Architecture

```text
User Browser
      ↓
CloudFront CDN
      ↓
S3 Static Website Hosting
      ↓
API Gateway
      ↓
AWS Lambda
      ↓
DynamoDB
```

---

## AWS Services Used

| Service           | Purpose                            |
| ----------------- | ---------------------------------- |
| Amazon S3         | Static website hosting             |
| Amazon CloudFront | Global CDN and HTTPS delivery      |
| API Gateway       | REST API exposure                  |
| AWS Lambda        | Serverless compute                 |
| DynamoDB          | Persistent visitor counter storage |
| IAM               | Identity and access management     |
| GitHub Actions    | CI/CD automation                   |
| Terraform         | Infrastructure as Code             |

---

## Infrastructure as Code (Terraform)

The infrastructure is fully provisioned using Terraform with a modularized configuration structure.

### Terraform Components

```text
terraform/
├── provider.tf
├── variables.tf
├── outputs.tf
├── s3.tf
├── cloudfront.tf
├── lambda.tf
├── dynamodb.tf
├── apigateway.tf
├── iam.tf
├── terraform.tfvars
└── backend.tf
```

### Key Terraform Features

* Remote backend state management using S3
* State locking using DynamoDB
* Modular infrastructure organization
* Variable-driven configuration
* Infrastructure reproducibility
* CI/CD-integrated validation workflow

---

## CI/CD Pipeline

GitHub Actions is used to automate Terraform validation and deployment workflows.

### Workflow Features

* Terraform formatting checks
* Terraform validation
* Terraform execution planning
* GitHub-hosted runners
* AWS authentication using OIDC federation
* Automated Lambda packaging

### GitHub Actions Flow

```text
Git Push
   ↓
GitHub Actions Runner
   ↓
Terraform Init
   ↓
Terraform Validate
   ↓
Terraform Plan
```

---

## Security Improvements

The project implements several infrastructure security best practices:

* IAM role-based authentication
* OIDC federation between GitHub Actions and AWS
* Remote Terraform state isolation
* DynamoDB state locking
* Public access control through CloudFront
* Terraform backend separation strategy

---

## Challenges Encountered

### Terraform Backend Bootstrap Problem

Resolved remote backend initialization failures caused by missing S3 backend infrastructure.

### GitHub Actions Workflow Discovery

Debugged workflow execution issues caused by incorrect `.github/workflows` directory placement.

### Terraform State Management

Resolved backend state loading and region alignment issues during CI/CD execution.

### Lambda Artifact Packaging

Implemented automated Lambda packaging workflow for CI/CD compatibility.

### CloudFront Migration

Migrated from manually configured CloudFront resources to Terraform-managed infrastructure.

### IAM and OIDC Configuration

Configured GitHub Actions authentication into AWS without long-lived access keys.

---

## Key Engineering Concepts Demonstrated

* Infrastructure as Code (IaC)
* CI/CD automation
* Remote state architecture
* Serverless architecture
* GitHub Actions automation
* OIDC federation
* Terraform backend management
* AWS IAM permissions
* CDN behavior and caching
* Cloud-native deployment workflows

---

## Future Improvements

* Multi-environment Terraform workspaces
* Terraform reusable modules
* Automated Terraform apply workflow
* CloudWatch monitoring and alerting
* Route 53 custom domain integration
* HTTPS certificate management with ACM
* Security scanning integration (tfsec / Checkov)
* Dockerized deployment workflows

---

## Lessons Learned

This project provided hands-on experience with real-world infrastructure automation challenges beyond basic cloud deployment.

Key lessons included:

* Terraform backend architecture design
* CI/CD orchestration troubleshooting
* GitHub Actions workflow behavior
* Infrastructure state management
* OIDC-based cloud authentication
* AWS IAM debugging
* Infrastructure reproducibility principles

---

## Author

GitHub: `https://github.com/davefilani-dev`






