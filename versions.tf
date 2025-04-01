# Terraform settings block 
terraform {
  # Terraform Version
  required_version = "~> 1.9" #constraints
  
  
  # Required terraform providers
  required_providers {
    aws = {
        version = "~> 5.91.0"
        source = "hashicorp/aws"
    }
  }

  # Backend 
  backend "s3" {
    bucket = "svcapi-tf-s3"
    region = "us-east-2"
    key = "dev/terraform.tfstate"
  }
}
