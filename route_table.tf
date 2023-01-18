resource "aws_default_route_table" "lab1" {
  default_route_table_id = aws_vpc.lab1.default_route_table_id

  # route {
   # cidr_block = "10.0.0.0/24"
   # subnet = private_subnet.lab1.id
  # } 

  route {
    cidr_block        = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab1.id
  }

  tags = {
    Name = "route_table_lab2_aws "
  }
}