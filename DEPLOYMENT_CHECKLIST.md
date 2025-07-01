# LAMP Stack Deployment Checklist

## Pre-Deployment Requirements

### 1. AWS Configuration
- [ ] AWS CLI configured with appropriate credentials
- [ ] Terraform installed (version >= 1.0)
- [ ] AWS region set correctly in terraform.tfvars (currently: eu-west-1)

### 2. Key Pair
- [ ] EC2 Key Pair "LampStack" exists in the target region
- [ ] You have access to the private key file

### 3. Security Review
- [ ] Database password changed from default (✅ Updated to secure password)
- [ ] Review security group rules for your use case
- [ ] Consider restricting SSH access to specific IP ranges

### 4. Cost Considerations
- [ ] NAT Gateway will incur charges (~$45/month)
- [ ] Consider using NAT Instance for cost savings in dev environments
- [ ] t3.micro instances are within free tier limits

## Deployment Steps

1. **Initialize Terraform**
   ```bash
   terraform init
   ```

2. **Plan Deployment**
   ```bash
   terraform plan
   ```

3. **Apply Configuration**
   ```bash
   terraform apply
   ```

4. **Verify Deployment**
   - Check load balancer URL from outputs
   - Test web application functionality
   - Verify database connectivity

## Post-Deployment

- [ ] Test the to-do application
- [ ] Verify SSL/TLS if implemented
- [ ] Set up monitoring and logging
- [ ] Configure backups
- [ ] Document access procedures

## Key Changes Made

✅ **Fixed Issues:**
- Replaced hardcoded AMI IDs with dynamic lookup
- Moved database to private subnet for security
- Fixed user data script parameter handling
- Added NAT Gateway for private subnet internet access
- Improved database security group rules
- Updated to stronger database password
- Enhanced outputs for better tracking

## Security Improvements Applied

- Database server isolated in private subnet
- Database only accessible from web servers
- SSH access to database restricted to VPC
- Stronger database password implemented