# 🚀 Terraform LAMP Stack on AWS

A production-ready, secure 3-tier LAMP (Linux, Apache, MySQL, PHP) stack deployed on AWS using Terraform. This infrastructure includes a web application server with a separate database server, load balancer, and proper security configurations.

## 🏗️ Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Internet      │    │   Public Subnet  │    │ Private Subnet  │
│   Gateway       │────│                  │    │                 │
│                 │    │  ┌─────────────┐ │    │ ┌─────────────┐ │
└─────────────────┘    │  │     ALB     │ │    │ │   Database  │ │
                       │  └─────────────┘ │    │ │   Server    │ │
                       │  ┌─────────────┐ │    │ └─────────────┘ │
                       │  │ Web Server  │ │    │                 │
                       │  └─────────────┘ │    │                 │
                       └──────────────────┘    └─────────────────┘
```

### Components
- **VPC**: Custom VPC with public and private subnets across 2 AZs
- **Application Load Balancer**: Distributes traffic to web servers
- **Web Server**: EC2 instance running Apache + PHP in public subnet
- **Database Server**: EC2 instance running MySQL in private subnet
- **NAT Gateway**: Enables private subnet internet access for updates
- **Security Groups**: Restrictive firewall rules following least privilege

## 📋 Features

- ✅ **Security First**: Database isolated in private subnet
- ✅ **High Availability**: Multi-AZ deployment ready
- ✅ **Load Balanced**: Application Load Balancer with health checks
- ✅ **Auto Scaling Ready**: Infrastructure prepared for scaling
- ✅ **Monitoring**: CloudWatch integration
- ✅ **Cost Optimized**: Uses t3.micro instances (free tier eligible)

## 🛠️ Prerequisites

### Required Tools
- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) configured
- SSH key pair in target AWS region

### AWS Permissions
Ensure your AWS credentials have permissions for:
- EC2 (instances, security groups, key pairs)
- VPC (subnets, route tables, internet gateway, NAT gateway)
- ELB (application load balancer)
- IAM (if using roles)

## 🚀 Quick Start

### 1. Clone Repository
```bash
git clone https://github.com/OnTrak-Tech/terraform-lampstack.git
cd terraform-lampstack
```

### 2. Configure Variables

**Option A: Environment Variables (Recommended)**
```bash
export TF_VAR_aws_region="eu-west-1"
export TF_VAR_key_name="your-key-pair-name"
export TF_VAR_db_name="lampdb"
export TF_VAR_db_username="admin"
export TF_VAR_db_password="YourSecurePassword123!"
```

**Option B: terraform.tfvars (Local Development)**
```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values
```

### 3. Deploy Infrastructure
```bash
# Initialize Terraform
terraform init

# Review deployment plan
terraform plan

# Deploy infrastructure
terraform apply
```

### 4. Access Your Application
After deployment, get the load balancer URL:
```bash
terraform output load_balancer_url
```

## 📁 Project Structure

```
terraform-lampstack/
├── main.tf                 # Main infrastructure configuration
├── variables.tf            # Variable definitions
├── outputs.tf             # Output definitions
├── terraform.tfvars.example # Example variables file
├── modules/               # Reusable Terraform modules
│   ├── vpc/              # VPC and networking
│   ├── security/         # Security groups
│   ├── web/              # Web server configuration
│   └── database/         # Database configuration
├── scripts/              # User data scripts
│   ├── db-tier.sh       # Database server setup
│   └── web-app-server.sh # Web server setup
├── environments/         # Environment-specific configs
│   └── dev/
├── deploy.sh            # Automated deployment script
├── DEPLOYMENT_CHECKLIST.md # Pre-deployment checklist
└── README.md           # This file
```

## 🔧 Configuration Options

### Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `aws_region` | AWS region for deployment | `us-east-1` | No |
| `instance_type` | EC2 instance type | `t3.micro` | No |
| `key_name` | EC2 Key Pair name | - | Yes |
| `db_name` | Database name | - | Yes |
| `db_username` | Database username | - | Yes |
| `db_password` | Database password | - | Yes |

### Customization
- Modify `variables.tf` to add new configuration options
- Update user data scripts in `scripts/` for custom application setup
- Adjust security group rules in `main.tf` for specific requirements

## 🔒 Security Best Practices

### Implemented Security Measures
- Database server in private subnet (no direct internet access)
- Security groups with least privilege access
- Database only accessible from web servers
- SSH access restricted to VPC for database
- Strong password requirements
- Encrypted storage options available

### Additional Recommendations
- Use AWS Secrets Manager for database credentials
- Enable VPC Flow Logs for network monitoring
- Implement SSL/TLS certificates
- Set up AWS CloudTrail for audit logging
- Use IAM roles instead of access keys

## 💰 Cost Considerations

### Monthly Costs (Approximate)
- **t3.micro instances (2)**: $0-17 (free tier eligible)
- **Application Load Balancer**: $16-22
- **NAT Gateway**: $45-50
- **Data transfer**: Variable

**Total**: ~$60-90/month (excluding free tier)

### Cost Optimization Tips
- Use NAT Instance instead of NAT Gateway for dev environments
- Consider Reserved Instances for production
- Monitor usage with AWS Cost Explorer
- Set up billing alerts

## 🚨 Troubleshooting

### Common Issues

**1. Key Pair Not Found**
```bash
# Create key pair in AWS Console or CLI
aws ec2 create-key-pair --key-name LampStack --query 'KeyMaterial' --output text > lampstack.pem
```

**2. Insufficient Permissions**
- Verify AWS credentials: `aws sts get-caller-identity`
- Check IAM permissions for required services

**3. Resource Limits**
- Check AWS service quotas in target region
- Verify VPC and subnet limits

**4. Application Not Loading**
- Check security group rules
- Verify user data script execution: `sudo tail -f /var/log/cloud-init-output.log`
- Test database connectivity from web server

## 🔄 Management Commands

### View Infrastructure
```bash
# Show current state
terraform show

# List resources
terraform state list

# Show outputs
terraform output
```

### Updates
```bash
# Plan changes
terraform plan

# Apply changes
terraform apply
```

### Cleanup
```bash
# Destroy infrastructure
terraform destroy
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

### Development Guidelines
- Follow Terraform best practices
- Update documentation for changes
- Test in multiple environments
- Use semantic versioning for releases

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

- Create an issue for bugs or feature requests
- Check existing issues before creating new ones
- Provide detailed information for troubleshooting

## 🔗 Related Resources

- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)

---

**Built with ❤️ using Terraform and AWS**