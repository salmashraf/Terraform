resource "aws_lb_target_group" "target-group" {
  target_type = var.target_type  
  for_each = var.target_group             
  name        = each.value
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpcID
  
  health_check {
    path = "/"
    port = 80
  }
}

resource "aws_lb_target_group_attachment" "ec2-target-group" {
  for_each = var.instanceID
  target_group_arn = each.value.targetGroup
  target_id = each.value.ec2
}

resource "aws_security_group" "loadbalancer_security" {
  name        = var.security_group
 #  description = var.security_group
  vpc_id      = var.vpcID

  ingress {
  #  description = var.protocol
    from_port   = 80
    to_port     = 80
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

resource "aws_lb" "alb" {
  load_balancer_type = var.load_balancer_type
  for_each = var.load_balancer
  name               = each.key
  internal           = each.value.internal     
  ip_address_type = var.ip_address_type

  security_groups    = [aws_security_group.loadbalancer_security.id]
  subnets            = each.value.subnets

}