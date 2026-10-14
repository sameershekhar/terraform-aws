terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.67.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.9.1"
    }
  }
}

provider "aws" {
  region = var.aws-region
}

resource "random_id" "rand_id" {
  byte_length = 8
}


resource "aws_s3_bucket" "tf-bucket" {
  bucket = "tf-demo-bucket${random_id.rand_id.hex}"
}

resource "aws_s3_object" "bucket_data" {
  bucket = aws_s3_bucket.tf-bucket.bucket
  source = "./myfile.txt"
  key    = "mydata.txt"
}
