#!/bin/bash

set -e

echo "🚀 LAMP Stack Deployment Script"
echo "================================"

# Check if terraform.tfvars exists
if [ ! -f "terraform.tfvars" ]; then
    echo "❌ terraform.tfvars not found!"
    echo "📝 Please copy terraform.tfvars.example to terraform.tfvars and customize it:"
    echo "   cp terraform.tfvars.example terraform.tfvars"
    exit 1
fi

# Check if Terraform is installed
if ! command -v terraform &> /dev/null; then
    echo "❌ Terraform is not installed!"
    echo "📥 Please install Terraform: https://www.terraform.io/downloads.html"
    exit 1
fi

# Check if AWS CLI is configured
if ! aws sts get-caller-identity &> /dev/null; then
    echo "❌ AWS CLI is not configured!"
    echo "🔧 Please configure AWS CLI: aws configure"
    exit 1
fi

echo "✅ Prerequisites check passed"
echo ""

# Initialize Terraform
echo "🔧 Initializing Terraform..."
terraform init

# Validate configuration
echo "🔍 Validating Terraform configuration..."
terraform validate

# Plan deployment
echo "📋 Planning deployment..."
terraform plan -out=tfplan

# Ask for confirmation
echo ""
read -p "🤔 Do you want to proceed with the deployment? (y/N): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🚀 Deploying LAMP stack..."
    terraform apply tfplan
    
    echo ""
    echo "🎉 Deployment completed successfully!"
    echo "🌐 Your LAMP application is now available at:"
    terraform output application_url
    
    echo ""
    echo "📊 To view all outputs:"
    echo "   terraform output"
    
    echo ""
    echo "🧹 To destroy the infrastructure later:"
    echo "   terraform destroy"
else
    echo "❌ Deployment cancelled"
    rm -f tfplan
fi