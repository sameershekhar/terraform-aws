terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.67.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "myserver-1" {
  ami           = "ami-01a00762f46d584a1"
  instance_type = "t3.nano"
}
