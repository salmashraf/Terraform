resource "aws_internet_gateway" "lab1" {
  vpc_id = aws_vpc.lab1.id

  tags = {
    Name = "igw_lab2"
  }
}
