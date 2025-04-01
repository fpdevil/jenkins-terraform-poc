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
  backend "s3" {
    bucket = "iacapi-tf-s3bucket"         # S3 bucket name
    region = "us-east-2"            # AWS region
    key = "dev/terraform.tfstate"   # S3 object key path
  }
}
