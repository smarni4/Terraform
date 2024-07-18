variable "instance_name" {
  description = "Name of the instance"
  type        = string
  default     = "Terraform_Demo"
}

variable "ec2_instance_type" {
  description = "Type of the instance"
  type        = string
  default     = "t2.micro"
}

variable "instance_count" {
  description = "Number of instances"
  type        = number
  default     = 2
}

variable "resource_tags" {
  description = "Required tags for the resources"
  type        = map(string)
  default = {
    project     = "Demo_project"
    environment = "dev"
    owner       = "Learning_Terraform147"
  }

}

variable "AWS_ACCESS_KEY" {
  description = "AWS_ACCESS_KEY"
  type = string
  default = " "
}

variable "AWS_SECRET_KEY" {
  description = " AWS_SECRET_KEY"
  type = string
  default = " "
}