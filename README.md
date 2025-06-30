# Three-Tier LAMP Stack on AWS with Terraform

This project provisions a complete three-tier LAMP (Linux, Apache, MySQL, PHP) stack on AWS using Terraform Infrastructure as Code (IaC).

## Architecture

- **Web Tier**: Apache + PHP on EC2 in public subnet
- **Application Tier**: PHP logic integrated with web tier
- **Database Tier**: MySQL RDS in private subnet
- **Network**: VPC with public/private subnets across multiple AZs
- **Security**: Security groups with least privilege access

## Prerequisites

- Terraform >= 1.0
- AWS CLI configured with appropriate credentials
- An existing EC2 Key Pair in your AWS region

## Quick Start

1. **Clone and navigate to the project:**
   ```bash
   cd terraform-lamp-stack
   ```

2. **Copy and customize the variables file:**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your specific values
   ```

3. **Initialize Terraform:**
   ```bash
   terraform init
   ```

4. **Plan the deployment:**
   ```bash
   terraform plan
   ```

5. **Deploy the infrastructure:**
   ```bash
   terraform apply
   ```

6. **Access your application:**
   - The web application URL will be displayed in the output
   - Visit the URL to see the LAMP stack in action

## Configuration

### Required Variables

- `key_name`: Your EC2 Key Pair name
- `db_password`: Secure password for MySQL database

### Optional Variables

- `aws_region`: AWS region (default: us-east-1)
- `vpc_cidr`: VPC CIDR block (default: 10.0.0.0/16)
- `web_instance_type`: EC2 instance type (default: t3.micro)

## Modules

- **VPC Module**: Creates VPC, subnets, internet gateway, and routing
- **Security Module**: Manages security groups for web and database tiers
- **Web Module**: Provisions EC2 instance with LAMP stack installation
- **Database Module**: Creates RDS MySQL instance in private subnet

## Features

- Automated LAMP stack installation via user data script
- PHP application with database connectivity test
- Visitor counter demonstrating database integration
- Security groups with proper access controls
- Multi-AZ deployment for high availability
- Encrypted RDS storage

## Cleanup

To destroy all resources:
```bash
terraform destroy
```

## Security Considerations

- Database is isolated in private subnets
- Security groups follow least privilege principle
- RDS storage is encrypted
- Consider using AWS Secrets Manager for database credentials in production

## Cost Optimization

- Uses t3.micro instances (free tier eligible)
- RDS with minimal storage allocation
- Resources can be easily scaled up/down as needed