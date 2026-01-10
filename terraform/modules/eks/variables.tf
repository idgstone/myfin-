variable "project_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "eks_security_group_id" {
  type = string
}

variable "eks_cluster_version" {
  type    = string
  default = "1.27"
}

variable "node_group_desired_size" {
  type    = number
  default = 2
}

variable "node_group_max_size" {
  type    = number
  default = 5
}

variable "node_group_min_size" {
  type    = number
  default = 1
}
