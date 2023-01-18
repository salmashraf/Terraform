resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow  http inbound traffic"


 ingress {
    description      = "Http from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.0/24"]
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "sg_http"
  }
}