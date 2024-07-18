# Terraform

* It allows you to manage infrastructure with configuration files rather than GUI.
* It allows to build, change and manage infrastructure in a safe, consistent, and repeatable way by configurations that 
  we can version, reuse, and share.
* Terraform is a cloud-agnostic, it means terraform doesn't care what cloud or infrastructure deployment method we are
  using.
* It works with a long list of cloud providers, database providers and much more.

## Terraform advantages:
* It can manage infrastructure on multiple cloud platforms.
* The human-readable configuration language helps you write code quickly.
* It allows tracking the resource changes throughout deployment.
* We can commit configurations to version control to safely collaborate on infrastructure.
* It interacts with the resources using API
* To initialize the terraform, run the command `terraform init`
* You can check the changes before applying them using dry-run feature by running the command `terraform plan`
* To apply the changes run the command `terraform apply`
* To destroy terraform, run the command `terraform destroy`

## Installation
* Run the command to install all homebrew packages of hashicorp on Mac using brew `brew tap hashicorp/tap`.
* Run the command to install terraform `brew install hashicorp/tap/terraform`

## Initialization
* Move to that directory and create a `main.tf` file and provide the configurations to create a `t2.micro instance`.
**main.tf**
```terraform
# terraform block
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

# Configure the region
provider "aws" {
  region = "us-east-1"
}

# creating instance with tag name Terraform_Demo
resource "aws_instance" "app_server" {    #"aws_instance": resource_type; "app_server": resource_name
  ami = "ami-0e731c8a588258d0d"
  instance_type = "t2.micro"
  
  tags = {
    Name = "Terraform_Demo"
  }
}
```
* To refer to the instance created above in other parts of configuration, you have to use the id `aws_instance.app_server` 
* To init the terraform project run the command `terraform init`, which downloads a plugin called provider that lets
  terraform interact with Docker.
* The `terraform fmt` command automatically updates the configurations in the current directory for readability.
* The `terraform validate` command validates that configuration is syntactically valid.
* After we apply the configuration, terraform writes the changes into terraform.tfstate file. We can see the content of
  the file using the command `terraform show`.
* To list the resources in our project, we can run the command `terraform state list`

## Variables
* you can assign the variables created in the `variables.tf` file in the configuration.
* Create a new file `variables.tf` and write the required variables inside it as shown below.
```terraform
variable "instance_name" {
  description: "Name of the instance"
  type: string
  default: "Terraform_Demo"
}
```
* Now, we can refer this variable `instance_name` in our main.tf file as 
```
tags = {
  Name = var.instance_name
 }
```
* We have to provide the value for the variable while running the apply command as `terraform apply -var "instance_name=New_Terraform_Name`
* We can write up all the variables into a file with extension .tfvars and specify that file while applying terraform
  using the flag `--var-file`.
```terraform
# terraform.tfvars
resource_tags = {
  project = "project_name"
  environment = "dev"
  owner = "me@example.com"
}

instance_type = "t3.micro"
instance_count = 3
```
* From the above snippet, we can refer to the variables as `var.resource_tags["project"]`.

## Outputs
* We can specify the outputs that we need using the `outputs.tf` file.
* Define the required outputs in thea outputs.tf file.
```terraform
output "instance_id" {
  description = "ID of the ec2-instance"
  value = aws_instance_app_server.id
}
```
* To print the output variables run the command `terraform output`

## Modules
* Modules help in organizing the configuration, by making it easier to navigate, understand, and update the
  configuration by keeping related parts of the project together.
* Modules are reusable.
* The directory that consists of terraform files is known as a module.
* When you run the terraform commands from the module, the CLI considers it as root module.
* We can call the modules from another module using the **module block**.
* Module called by other configuration is sometimes known as **child module**.
* Modules can either be local or remote such as terraform cloud, version control systems,terraform registry.

