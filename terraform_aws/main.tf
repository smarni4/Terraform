terraform { # terraform block
  cloud {
    organization = "Learning_Terraform147"
    workspaces {
      name = "Python_for_DevOps"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-07761f3ae34c4478d"
  instance_type = var.ec2_instance_type
  count         = var.instance_count


  tags = {
    Name = var.instance_name
  }
}