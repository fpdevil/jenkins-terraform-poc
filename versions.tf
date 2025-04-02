# Terraform settings block 
terraform {
  # Terraform Version
  required_version = "~> 1.9" # constraints 1.9.x and above
  
  
  # Required terraform providers
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.83.0"
    }
  }

  # Using S3 as the remote backend for storing the Terraform state  
  # Backend configuration for storing state to S3 bucket
  # Variables cannot be used in the backend block and hence
  # are being passed in backend.hcl file
  backend "s3" {
  }
}
