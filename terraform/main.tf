terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Uncomment for remote state
  # backend "s3" {
  #   bucket         = "myfin-terraform-state"
  #   key            = "terraform.tfstate"
  #   region         = "us-east-1"
  #   encrypt        = true
  #   dynamodb_table = "terraform-locks"
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = "PerFin"
      ManagedBy   = "Terraform"
    }
  }
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"

  project_name       = var.project_name
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
}

# EKS Module
module "eks" {
  source = "./modules/eks"

  project_name           = var.project_name
  subnet_ids             = concat(module.vpc.public_subnet_ids, module.vpc.private_subnet_ids)
  eks_security_group_id  = module.vpc.eks_security_group_id
  eks_cluster_version    = var.eks_cluster_version
  node_group_desired_size = var.eks_node_group_desired_size
  node_group_max_size     = var.eks_node_group_max_size
  node_group_min_size     = var.eks_node_group_min_size
}

# RDS Module
module "rds" {
  source = "./modules/rds"

  project_name             = var.project_name
  environment              = var.environment
  vpc_id                   = module.vpc.vpc_id
  vpc_cidr                 = var.vpc_cidr
  subnet_ids               = module.vpc.private_subnet_ids
  rds_allocated_storage    = var.rds_allocated_storage
  rds_instance_class       = var.rds_instance_class
  rds_engine_version       = var.rds_engine_version
  rds_db_name              = var.rds_db_name
  rds_username             = var.rds_username
  rds_password             = var.rds_password
  rds_backup_retention_days = var.rds_backup_retention_days
}

# Monitoring Module
module "monitoring" {
  source = "./modules/monitoring"

  project_name      = var.project_name
  environment       = var.environment
  aws_region        = var.aws_region
  log_retention_days = var.environment == "prod" ? 30 : 7
  alert_email       = var.alert_email
}

# Outputs
output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
}

output "eks_cluster_name" {
  value       = module.eks.cluster_name
  description = "EKS cluster name"
}

output "eks_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "EKS cluster endpoint"
}

output "rds_endpoint" {
  value       = module.rds.db_instance_endpoint
  description = "RDS database endpoint"
}

output "rds_port" {
  value       = module.rds.db_instance_port
  description = "RDS database port"
}

output "sns_topic_arn" {
  value       = module.monitoring.sns_topic_arn
  description = "SNS topic for alerts"
}
