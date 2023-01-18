data "aws_ami" "ubuntu" {
  most_recent = true
}

resource "aws_instance" "web" {
  ami           = "ami-06878d265978313ca"
  instance_type = "t2.micro"
  subnet_id       = aws_subnet.private_subnet.id
   
   user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  echo "*** Completed Installing apache2"
  EOF

  tags = {
    Name = "lab1_instance"
  }
}

