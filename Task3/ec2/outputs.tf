/* output "public_ec2_public_ip" {
    value = aws_instance.public-ec2.public_ip
    
}
output "public_ec2_private_ip" {
  value = aws_instance.public-ec2.private_ip
  
} 
output "private_ec2_private_ip" {
  value = aws_instance.priv.private_ip
  
} */ 
output "ec2_sg_id" {
  value = aws_security_group.ec2_security.id
}

 output "public_ec2_id_1" {
  value = aws_instance.public-ec2["public_ec2_1"].id
}

output "public_ec2_id_2" {
  value = aws_instance.public-ec2["public_ec2_2"].id
}  

output "private_ec2_id_1" {
  value = aws_instance.private-ec2["private_ec2_1"].id
}

output "private_ec2_id_2" {
  value = aws_instance.private-ec2["private_ec2_2"].id
} 