# Terraform configuration
terraform {
    required_version = ">=1.2.8"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "4.29.0"
        }
    }
    backend "s3" {
        bucket = "jsconf_laprevia_terraform"
        key    = "terraform/state"
        region = "us-east-1"
        profile = "jsconf_laprevia"
    }
}

# Provider configuration
provider "aws" {
    region = var.region
    profile = "jsconf_laprevia"
}