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

resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_object" "index_html" {
    bucket = aws_s3_bucket.website_bucket.id
    key = "index.html"
    source = "Atlas/index.html"
    etag = filemd5("Atlas/index.html")
    content_type = "text/html"
}

resource "aws_s3_object" "error_html" {
    bucket = aws_s3_bucket.website_bucket.id
    key = "error.html"
    source = "Atlas/error.html"
    etag = filemd5("Atlas/error.html")
    content_type = "text/html"
}

resource "aws_cloudfront_origin_access_identity" "aws_cloudfront_origin_access_identity" {
    comment= "Origin Access Identity for static website"
  
}

resource "aws_cloudfront_distribution" "aws_cloudfront_distribution" {
  origin{
    domain_name = aws_s3_bucket.website_bucket.bucket_regional_domain_name
    origin_id = var.bucket_name

    s3_origin_config {
    origin_access_identity = aws_cloudfront_origin_access_identity.aws_cloudfront_origin_access_identity.cloudfront_access_identity_path
    }
  }
enabled = true  
is_ipv6_enabled = true
default_root_object = var.website_index_document

default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]
    target_origin_id = var.bucket_name
}
}
