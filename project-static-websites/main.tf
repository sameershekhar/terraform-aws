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
  region = "ap-south-1"
}

resource "random_id" "rand_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "tf-web-bucket" {
  bucket = "tf-web-bucket${random_id.rand_id.hex}"
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.tf-web-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "tf-web-app-plocy" {
  bucket = aws_s3_bucket.tf-web-bucket.id
  policy = jsondecode(
    {
      Version = "2012-10-17",
      Statement = [
        {
          Sid       = "PublicReadGetObject",
          Effect    = "Allow",
          Principal = "*",
          Action = [
            "s3:GetObject"
          ],
          Resource = [
            "arn:aws:s3:::${aws_s3_bucket.tf-web-bucket.id}/*"
          ]
        }
      ]
    }
  )
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.tf-web-bucket.bucket
  source = "./index.html"
  key    = "index.txt"
}

resource "aws_s3_object" "styles_css" {
  bucket = aws_s3_bucket.tf-web-bucket.bucket
  source = "./styles.css"
  key    = "styles.css"
}


