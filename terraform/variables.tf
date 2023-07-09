variable "aws_region" {
  type        = string
  description = "The AWS region to create resources in."
  default     = "eu-west-2"
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags"
  default = {
    "Managed_by" = "Terraform",
    "Project"    = "SNS Django app prototype"
  }
}

# NETWORK 
variable "cidr_block" {
  type        = string
  description = "AWS VPC CIDR block"
}

variable "public_1_cidr_block" {
  type        = string
  description = "AWS public subnet 1 CIDR block"
}

variable "public_2_cidr_block" {
  type        = string
  description = "AWS public subnet 2 CIDR block"
}

variable "private_1_cidr_block" {
  type        = string
  description = "AWS private subnet 1 CIDR block"
}

variable "private_2_cidr_block" {
  type        = string
  description = "AWS private subnet 2 CIDR block"
}

# Load balancer 
variable "health_check_path" {
  type        = string
  description = "Health check path for the default target group"
  default     = "/ping/"
}

# ECS 
variable "ecs_cluster_name" {
  type        = string
  description = "ECS cluster name"
  default     = "sns-django-app-prototype"
}

# Logs 
variable "log_retention_in_days" {
  type    = number
  default = 30
}

# Key Pair
variable "ssh_pubkey_file" {
  type        = string
  description = "Path to an SSH public key"
  default     = "~/.ssh/id_rsa.pub"
}