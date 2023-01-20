resource "aws_route_table_association" "public-route" {
  subnet_id      = aws_subnet.subnets[0].id
  route_table_id = aws_route_table.public_route_table.id
}
