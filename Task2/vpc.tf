resource "aws_vpc" "lab2" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "vpc_aws_lab2"
  }
}