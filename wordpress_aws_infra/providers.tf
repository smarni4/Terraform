terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.46"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
  # Add aws access_key and secret_key

}
