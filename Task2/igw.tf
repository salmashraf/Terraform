resource "aws_internet_gateway" "lab2" {
  vpc_id = aws_vpc.lab2.id

  tags = {
    Name = "igw_lab2"
  }
}
