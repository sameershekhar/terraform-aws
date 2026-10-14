terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.67.0"
    }
  }
  backend "s3" {
    bucket = "tf-demo-bucket1234"
    key    = "backend.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "myserver-2" {
  ami           = "ami-01a00762f46d584a1"
  instance_type = "t3.micro"
}
