resource "aws_eip" "elastic_ip" {
  vpc = true
}

resource "aws_nat_gateway" "Nat" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id = aws_subnet.subnets[0].id
  tags = {
    "Name" = "NatGateway"
  }
    depends_on = [aws_internet_gateway.lab2]
}


resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.lab2.id
  route {
    cidr_block = var.pub_route
    gateway_id = aws_nat_gateway.Nat.id
  }
  tags = {
    Name = "private-rout_table"
  }
}

resource "aws_route_table_association" "private_route_table" {
  subnet_id = aws_subnet.subnets[1].id
  route_table_id = aws_route_table.private_route_table.id
}

