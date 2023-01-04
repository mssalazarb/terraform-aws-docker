provider "aws" {
  region = var.region
}

resource "aws_instance" "demo-ec2-tf" {
  ami = var.ami_id
  instance_type = var.instance_type
  tags = var.tags
}