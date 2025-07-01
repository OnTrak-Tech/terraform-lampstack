output "load_balancer_url" {
  description = "URL of the Application Load Balancer"
  value       = "http://${aws_lb.main.dns_name}"
}

output "load_balancer_dns" {
  description = "DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}

output "web_server_ip" {
  description = "Public IP of the web server"
  value       = aws_instance.web.public_ip
}

output "database_server_ip" {
  description = "Private IP of the database server"
  value       = aws_instance.db.private_ip
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}