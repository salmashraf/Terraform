resource "aws_vpc" "lab1" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc_aws_lab1"
  }
}