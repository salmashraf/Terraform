resource "aws_instance" "web" {
  ami           = "ami-06878d265978313ca"
  instance_type = var.instance_type
  subnet_id       = aws_subnet.subnets[0].id
  associate_public_ip_address=true
  vpc_security_group_ids             = [aws_security_group.allow_http.id]

   user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  echo "*** Completed Installing apache2"
  EOF

  tags = {
    Name = "public_instance"
  }
}
