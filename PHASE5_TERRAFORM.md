# Phase 5: Infrastructure as Code with Terraform

## Overview

Terraform setup để automate AWS infrastructure - VPC, EKS cluster, RDS database.

## Project Structure
```
terraform/
├── main.tf              # Provider config + modules
├── variables.tf         # Variables
├── modules/
│   ├── vpc/            # VPC + networking
│   ├── eks/            # Kubernetes cluster
│   ├── rds/            # MySQL database
│   └── monitoring/     # CloudWatch
└── environments/
    ├── dev/            # Development config
    ├── staging/        # Staging config
    └── prod/           # Production config
```

## Setup

### Prerequisites
- AWS Account
- Terraform 1.0+
- AWS CLI configured

### Initialize
```bash
cd terraform/environments/dev
terraform init
```

### Plan & Apply
```bash
# See what will be created
terraform plan

# Create infrastructure
terraform apply
```

## Modules Included

**VPC:** VPC, subnets, NAT gateways, security groups
**EKS:** Kubernetes cluster + node groups
**RDS:** MySQL database with automated backups
**Monitoring:** CloudWatch logs + alarms

## AWS Resources

Total: ~35 resources managed per environment
- 1 VPC
- 6 Subnets (3 public, 3 private)
- 3 NAT Gateways
- 1 EKS Cluster
- 1 Node Group
- 1 RDS Instance
- Security groups, IAM roles, etc.

## Security

- RDS encryption at rest
- Private subnets for databases
- IAM least privilege
- Automated backups (1-30 days)
- CloudWatch monitoring

## State Management

Local: `terraform.tfstate`

For production, use S3 backend:
```hcl
backend "s3" {
  bucket = "myfin-terraform-state"
  key    = "prod/terraform.tfstate"
  region = "us-east-1"
}
```

## Common Commands
```bash
# Validate
terraform validate

# Plan
terraform plan

# Apply
terraform apply

# State
terraform state list
terraform state show aws_eks_cluster.main

# Destroy
terraform destroy
```

