output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_ec2_id" {
  value = aws_instance.public.id
}

output "public_ec2_ip" {
  value = aws_instance.public.public_ip
}

output "private_ec2_id" {
  value = aws_instance.private.id
}

output "private_ec2_ip" {
  value = aws_instance.private.private_ip
}

output "alb_dns_name" {
  value = aws_lb.app.dns_name
}

output "ecr_repository_url" {
  value = aws_ecr_repository.app.repository_url
}

output "github_actions_role_arn" {
  value = aws_iam_role.github_actions.arn
}