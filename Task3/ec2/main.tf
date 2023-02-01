resource "aws_security_group" "ec2_security" {
  name        = var.security_group
  vpc_id      = var.vpcID

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.pub_cidr
  }

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.pub_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.pub_cidr
  }

  tags = {
    Name = var.security_group
  }
}

resource "aws_instance" "public-ec2" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  for_each = var.public_ec2_subnet
  subnet_id                   = each.value
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ec2_security.id]
  key_name = "last-key"

  tags = {
    Name = each.key
  } 

 # to save public ip in a file
  provisioner "local-exec" {
        command = "echo 'public ip for ${each.key}: ${self.public_ip}' >> ./all-ips.txt"   
    }
  
 # to save private ip in a file
  provisioner "local-exec" {
        command = "echo 'private ip for ${each.key}: ${self.private_ip}' >> ./all-ips.txt"   
    }     
      
 

provisioner "remote-exec" {
        inline = [
        "sudo apt update -y",
        "sudo apt install -y nginx",
        "echo 'server { \n listen 80 default_server; \n  listen [::]:80 default_server; \n  server_name _; \n  location / { \n  proxy_pass http://${var.private_alb_dns}; \n  } \n}' > default",
        "sudo mv default /etc/nginx/sites-enabled/default",
        "sudo systemctl stop nginx",
        "sudo systemctl start nginx"
        ]
    }
       
    connection {
        type = "ssh"
        host = self.public_ip
        user = "ubuntu"
        private_key = file("./last-key.pem")
        timeout = "4m"
    }
  }

  resource "aws_instance" "private-ec2" {
  ami                         = var.instance_ami                 
  for_each = var.private_ec2_subnet
  instance_type               = var.instance_type
  subnet_id                   = each.value
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.ec2_security.id]

  user_data = <<-EOF
  #!/bin/bash
  sudo apt update -y
  sudo apt install apache2 -y
  sudo systemctl start apache2
  sudo systemctl enable apache2
  EOF

  tags = {
    Name = each.key
  }
  provisioner "local-exec" {
        command = "echo 'private ip for ${each.key}: ${self.private_ip}' >> ./all-ips.txt"   
  }
}  

/* resource "aws_instance" "web" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  vpc_id = module.lab3-vpc.vpc-id
  subnet_id       = aws_subnet.subnets[0].id
  associate_public_ip_address=true
  vpc_security_group_ids   = [aws_security_group.allow_http.id]
  
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
} */ 