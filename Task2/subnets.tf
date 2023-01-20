resource "aws_subnet" "subnets" {
  count = length(var.subnet_cidr)
  cidr_block = var.subnet_cidr[count.index]
  vpc_id     = aws_vpc.lab2.id

  tags = {
    Name = var.subnet_cidr[count.index]
  }
}
