resource "aws_s3_bucket" "tf_backend_bucket" {
  bucket = "tf-remote-backet-17102025"

  tags = {
    Name        = "terraform backend bucket"
    Environment = "Dev"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}