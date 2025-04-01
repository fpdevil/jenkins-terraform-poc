# Terraform settings block 
terraform {
  # Terraform Version
  required_version = "~> 1.9" # constraints 1.9.x and above
  
  
  # Required terraform providers
  required_providers {
    aws = {
        version = "~> 5.91.0"
        source = "hashicorp/aws"
    }
  }

  # Using S3 as the remote backend for storing the Terraform state  
  backend "s3" {
    bucket = "svcapi-tf-s3"         # S3 bucket name
    region = "us-east-2"            # AWS region
    key = "dev/terraform.tfstate"   # S3 object key path
  }
}
