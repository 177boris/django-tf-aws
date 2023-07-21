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

# ECS 
/* variable "ecs_cluster_name" {
  type        = string
  description = "ECS cluster name"
  default     = "sns-django-app-prototype"
} */

variable "ecs_cluster_name" {
  type        = string
  description = "Name of the ECS cluster"
  default     = "production"
}

variable "amis" {
  type        = map(string)
  description = "Which AMI to spawn."
  default = {
    us-west-1 = "ami-0bd3976c0dbacc605" #TODO Change AMI ID to the correct region 
  }
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "docker_image_url_django" {
  type        = string
  description = "Docker image to run in the ECS cluster"
  default     = "216761891772.dkr.ecr.eu-west-2.amazonaws.com/django-app:latest" #TODO update this
}

variable "app_count" {
  type        = string
  description = "Number of Docker containers to run"
  default     = 2
}

# ASG 
variable "autoscale_min" {
  type        = number
  description = "Minimum autoscale (number of EC2)"
  default     = "1"
}
variable "autoscale_max" {
  type        = number
  description = "Maximum autoscale (number of EC2)"
  default     = "5"
}
variable "autoscale_desired" {
  type        = number
  description = "Desired autoscale (number of EC2)"
  default     = "2"
}
