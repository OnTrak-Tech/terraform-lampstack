variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "AWS Key Pair name"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
  sensitive   = true
}

variable "db_username" {
  description = "Database username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "setup_script_url" {
  description = "URL to the setup script in GitHub"
  type        = string
  default     = "https://raw.githubusercontent.com/your-username/your-repo/main/scripts/setup.sh"
}

variable "app_repo_url" {
  description = "URL to the application repository"
  type        = string
  default     = "https://github.com/your-username/your-app-repo.git"
}