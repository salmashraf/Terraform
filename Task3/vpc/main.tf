resource "aws_vpc" "vpc1" {
 cidr_block = var.vpc_cidr
 tags = {
    "Name" = var.vpc_name
 }
}

resource "aws_subnet" "subnets_public" {
  vpc_id     = aws_vpc.vpc1.id
  for_each = var.public_subnets
  cidr_block = each.value.cidr
  availability_zone = each.value.az
  tags = {
   Name = each.key
  }
} 

resource "aws_subnet" "subnets_private" {
  for_each = var.private_subnets
  cidr_block = each.value.cidr
  vpc_id     = aws_vpc.vpc1.id
  availability_zone = each.value.az
  tags = {
   Name = each.key
  }
} 

