terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

module "webserver" {
  source = "./modules/webserver"

  key_name  = var.key_name
  subnet_id = aws_subnet.subnet-webserver.id
  vpc_id    = aws_vpc.lamp-vpc.id
  owner     = var.owner
}

#Setup Network Structure
resource "aws_vpc" "lamp-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name  = "LAMP VPC"
    Owner = "${var.owner}"
  }
}

resource "aws_subnet" "subnet-webserver" {
  vpc_id                  = aws_vpc.lamp-vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = true

  tags = {

    Name  = "subnet-webserver"
    Owner = "${var.owner}"

  }
}

resource "aws_subnet" "subnet-database" {
  vpc_id                  = aws_vpc.lamp-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-north-1b"
  map_public_ip_on_launch = true

  tags = {

    Name  = "subnet-database"
    Owner = "${var.owner}"

  }
}

resource "aws_internet_gateway" "igw_lamp" {
  vpc_id = aws_vpc.lamp-vpc.id

  tags = {
    Name  = "LAMP - IGW"
    Owner = "${var.owner}"
  }
}

resource "aws_route" "rt_lamp_webserver" {
  route_table_id         = aws_vpc.lamp-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_lamp.id


}