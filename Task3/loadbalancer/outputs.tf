output "public_alp_target_group_id" {
  value = aws_lb_target_group.target-group["public"].id
}

output "private_alp_target_group_id" {
  value = aws_lb_target_group.target-group["private"].id
}

output "public_load_balancer_id" {
  value = aws_lb.alb["publicAlb"].id
}

output "private_load_balancer_id" {
  value = aws_lb.alb["privateAlb"].id
}
