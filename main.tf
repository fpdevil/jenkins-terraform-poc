# Resource: S3 bucket
resource "aws_s3_bucket" "s3_tf_state" {
  # name of the S3 bucket
  bucket = var.s3_bucket_name

  # prevent any accidental deletion of the S3 bucket
  # terraform will exit with error when run `terraform destrory`
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "TF S3 Bucket"
  }
}

resource "aws_instance" "ec2-instance" {
    count = var.instance_count
    ami = var.ami_id
    availability_zone = var.availability_zone
    instance_type = var.instance_type
    tags = {
       "Name" = "${var.env}-websvr-${count.index}"
    }
}
