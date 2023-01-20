resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.lab2.id

  route {
    cidr_block        = var.pub_route
    gateway_id = aws_internet_gateway.lab2.id
  }

  tags = {
    Name = "public_route_table "
  }
}

