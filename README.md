# TwoStepsForward-
Using TerraForm AWS CLI to deploy AWS infrastructure to house the code for a single page HTML website

Steps to set up AWS CLI:
 Command : 
aws configure sso (single sign on)

AWS_PROFILE="AWSAdministratorAccess-216989112359" aws sso login
Project Structure for Terraform:
(within AWS)[S3 -> CloudFront -> Route 53(not covered) - > website ] -> users


TF FILE : 
Example Usage


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

