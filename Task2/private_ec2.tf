resource "aws_instance" "priv" {
  ami           = "ami-00874d747dde814fa"
  instance_type = var.instance_type
  subnet_id = aws_subnet.subnets[1].id
  vpc_security_group_ids            = [aws_security_group.allow_http.id]
  associate_public_ip_address = false
  
  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  echo "*** Completed Installing apache2"
  EOF

  tags = {
    Name = "private_instance"
  }
}