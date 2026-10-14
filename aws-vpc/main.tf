terraform {
  required_providers {
    aws = {
      source  = "value"
      version = "value"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

#Create a vpc
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my_vpc"
  }
}

#Create a private subnet
resource "aws_subnet" "private_subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.my_vpc.id
  tags = {
    Name = "private_subnet"
  }
}

resource "aws_subnet" "public_subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id     = aws_vpc.my_vpc.id
}


resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my-igw"
  }
}

resource "aws_route_table" "my-rt" {

}
