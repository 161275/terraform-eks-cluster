
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = "tf-remote-backet-17102025"
    key = "Dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

