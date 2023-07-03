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
