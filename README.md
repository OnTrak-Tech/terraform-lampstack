# Terraform LAMP Stack

## Setup Instructions

### 1. Clone and Configure
```bash
git clone <your-repo-url>
cd terraform-lampstack
```

### 2. Set Environment Variables (Recommended)
```bash
export TF_VAR_db_name="your_database_name"
export TF_VAR_db_username="your_db_username"
export TF_VAR_db_password="your_secure_password"
export TF_VAR_key_name="your-key-pair-name"
```

### 3. Alternative: Use terraform.tfvars (Local Only)
```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your actual values
```

### 4. Deploy
```bash
terraform init
terraform plan
terraform apply
```

## Security Notes
- Never commit `terraform.tfvars` files
- Use environment variables for sensitive data
- All sensitive variables are marked with `sensitive = true`
- State files contain sensitive data - store remotely with encryption