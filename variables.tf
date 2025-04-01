variable "instance_count" {
    description = "The number of instances to be spinned"
    type = number
    #default = 2
}

variable "availability_zone" {
  description = "The Availability zone where the infrastructure will be created"
  type = string
  #default = "us-east-2a"
}

variable "instance_type" {
  description = "The type of the EC2 instance to be created"
  type =  string
  #default = "t2.micro"
}

variable "ami_id" {
  description = "The AMI ID needed for EC2"
  type = string
  #default = "ami-08b5b3a93ed654d19"
}

variable "env" {
  description = "The environment under consideration"
  type = string
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  type = string
}