resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow  http inbound traffic"
  vpc_id      = aws_vpc.lab2.id


 ingress {
    description      = "Http from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = var.pub_cidr
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = var.pub_cidr
  }
  
  tags = {
    Name = "sg_http"
  }
}