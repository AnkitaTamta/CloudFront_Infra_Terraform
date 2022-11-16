## Values for S3 

variable "bucket_name" {
  description = "S3 bucket name, based on environment."
  type        = "map"

  default = {
    PROD    = "demo.example.com"
    STG     = "demo-stg.example.com"
    QA      = "demo-qa.example.com"
    DEV     = "demo-dev.example.com"
  }
}

variable "region" {
  default = "us-east-1"
}

variable "acl" {
  default = ""
}

## Values for Cloudfront 

variable "alias" {
  type        = "map"

  default = {
    PROD    = "demo.example.com"
    STG     = "demo-stg.example.com"
    QA      = "demo-qa.example.com"
    DEV     = "demo-dev.example.com"
  }
}

variable "http_version" {
  default = "http2"
}

variable "origin_access_identity_comment" {
  type        = "map"

  default = {
    PROD    = "CF Identity for demo.example.com"
    STG     = "CF Identity for demo-stg.example.com"
    QA      = "CF Identity for demo-qa.example.com"
    DEV     = "CF Identity for demo-dev.example.com"
  }
}

variable "enabled" {
  default = "true"
}

variable "is_ipv6_enabled" {
  default = "true"
}

variable "comment" {
  type        = "map"

  default = {
    PROD    = "demo.example.com"
    STG     = "demo-stg.example.com"
    QA      = "demo-qa.example.com"
    DEV     = "demo-dev.example.com"
  }
}

variable "default_root_object" {
  default = "index.html"
}

variable "log_include_cookies" {
  default     = "false"
  description = "Include cookies in access logs"
}

variable "log_prefix" {
  type        = "map"

  default = {
    PROD    = "CloudFront/demo.example.com/"
    STG     = "CloudFront/demo-stg.example.com/"
    QA      = "CloudFront/demo-qa.example.com/"
    DEV     = "CloudFront/demo-dev.example.com/"
  }
}

variable "price_class" {
  default = "PriceClass_All"
}

variable "web_acl_id" {
  default = ""
}

variable "allowed_methods" {
  type        = "list"
  default     = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
  description = "List of allowed methods (e.g. ` GET, PUT, POST, DELETE, HEAD`) for AWS CloudFront"
}

variable "cached_methods" {
  type        = "list"
  default     = ["GET", "HEAD"]
  description = "List of cached methods (e.g. ` GET, PUT, POST, DELETE, HEAD`)"
}

variable "query_string" {
  default = "false"
}

variable "forward_cookies" {
  default = "none"
}

variable "viewer_protocol_policy" {
  default = "redirect-to-https"
}

variable "min_ttl" {
  default = "0"
}

variable "default_ttl" {
  default = "300"
}

variable "max_ttl" {
  default = "300"
}

variable "geo_restriction_type" {
  default = "none"
}

variable "costcenter" {
  default = "12345"
}

variable "repo_name" {
  default = "TFRepo"
}

variable "environment" {
  type        = "map"

  default = {
    PROD    = "Prod"
    STG     = "STG"
    QA      = "qa"
    DEV     = "DEV"
  }
}

variable "api_endpoint" {
  type = "map"

  default = {
    PROD  = "demo_api_endpoint.api.example.com"
    STG   = "demo.api.example.com"
    QA    = "demo.api.example.com"
    DEV   = "demo.api.example.com"
  }
}

variable "service" {
  default = "SecureMobilePlatform"
}

variable "viewer_minimum_protocol_version" {
  default = "TLSv1"
}

variable "cloudfront_default_certificate" {
  default = "false"
}

variable "ssl_support_method" {
  default = "sni-only"
}

variable "iam_certificate_id" {
  default = ""
}

variable "metric_name" {
  default = "wafdemo"
}

variable "priority" {
  default = "1"
}

variable "type" {
  default = "REGULAR"
}

variable hosted_zone_id {
  description = "ID for the domain hosted zone"
  default = "ABC12345"
}

variable domain_name {
  description = "Name of the domain where record(s) need to create"
  default = "democloudfront.net"
}

variable route53_record_name {
	description = "Name of the record that you want to create"
  type = "map"
  	default = {
    PROD    = "demo"
    STG     = "demo-stg"
    QA      = "demo-qa"
    DEV     = "demo-dev"
    }
}

variable alias_zone_id {
	description = "Fixed constant zone_id that is used for all CloudFront distributions"
	default = ""
}
