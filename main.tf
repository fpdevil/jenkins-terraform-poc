resource "aws_instance" "ec2-instance" {
    count = var.instance_count
    ami = var.ami_id
    availability_zone = var.availability_zone
    instance_type = var.instance_type
    tags = {
       "Name" = "${var.env}-websvr-${count.index}"
    }
}
