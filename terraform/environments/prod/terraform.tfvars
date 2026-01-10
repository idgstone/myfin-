aws_region            = "us-east-1"
environment           = "prod"
project_name          = "myfin"
vpc_cidr              = "10.2.0.0/16"
availability_zones    = ["us-east-1a", "us-east-1b", "us-east-1c"]

# EKS Configuration
eks_cluster_version         = "1.27"
eks_node_group_desired_size = 3
eks_node_group_max_size     = 10
eks_node_group_min_size     = 3

# RDS Configuration
rds_allocated_storage      = 100
rds_instance_class         = "db.t3.medium"
rds_engine_version         = "8.0"
rds_db_name                = "myfin"
rds_username               = "admin"
rds_password               = "ChangeMe789!"
rds_backup_retention_days  = 30
alert_email            = "your-email@gmail.com"
