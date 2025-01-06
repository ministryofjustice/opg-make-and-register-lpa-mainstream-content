output "app_fqdn" {
  value = aws_route53_record.app.fqdn
}

output "app_load_balancer_security_group" {
  value = module.app.load_balancer_security_group
}
