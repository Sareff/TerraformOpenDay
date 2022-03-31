terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}


provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true


  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  owners = ["amazon"]
}

resource "aws_iam_instance_profile" "s3-ec2-profile-task-1" {
  name = "s3-ec2-profile-task-1"
  role = "EC2FullAccessToS3" # Name of created role with IAM
}

resource "aws_instance" "demo1" {
  ami           = data.aws_ami.amazon-linux-2.id
  instance_type = "t2.micro"

  tags = {
    Name = "Demo1"
  }

  iam_instance_profile = aws_iam_instance_profile.s3-ec2-profile-task-1.name

  security_groups = ["SSH-HTTP/S"]

  user_data = filebase64("userdata.sh")
}

output "ec2_global_ips" {
  value = ["${aws_instance.demo1.*.public_ip}"]
}


