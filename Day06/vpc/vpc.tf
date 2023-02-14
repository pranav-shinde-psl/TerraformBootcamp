resource "aws_vpc" "psl_vpc" {
  cidr_block           = var.cidr_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "tfbootcamp-vpc"
  }
}