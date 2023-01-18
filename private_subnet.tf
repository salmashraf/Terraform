resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.lab1.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "aws_lab2_subnet"
  }
}
