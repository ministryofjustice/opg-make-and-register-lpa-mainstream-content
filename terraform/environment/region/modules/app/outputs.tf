output "load_balancer" {
  description = "The load balancer DNS name"
  value       = aws_lb.app
}
