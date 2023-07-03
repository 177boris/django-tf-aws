terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "sns-proto-django-app-terraform"
    key    = "django-app.tfstate"
    region = "eu-west-2"
  }
}

# Configure aws provider 
provider "aws" {
  region = var.aws_region
  default_tags {
    tags = var.default_tags
  }
}
