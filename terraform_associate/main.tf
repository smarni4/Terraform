provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my-first-tf-node" {
  ami = ""
  subnet_id = ""
  instance_type = "t3.micro"
}
