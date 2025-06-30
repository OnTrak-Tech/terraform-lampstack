output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "web_instance_public_ip" {
  description = "Public IP of web server"
  value       = module.web.public_ip
}

output "web_instance_public_dns" {
  description = "Public DNS of web server"
  value       = module.web.public_dns
}

output "application_url" {
  description = "URL to access the LAMP application"
  value       = "http://${module.web.public_dns}"
}