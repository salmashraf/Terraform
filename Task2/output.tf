output "public_ec2_public_ip" {
    value = aws_instance.web.public_ip
    
}
output "public_ec2_private_ip" {
  value = aws_instance.web.private_ip
  
}
output "private_ec2_private_ip" {
  value = aws_instance.priv.private_ip
  
}

# } 