# Terraform module for creating Cloudfront, ACM certificate and route53

# ACM certificate will be created and an email will be sent for approval

resource "aws_acm_certificate" "cert" 
{
  domain_name        = "${var.alias}"
  validation_method  = "EMAIL"
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" 
{
  comment = "${var.origin_access_identity_comment}"
}

resource "aws_cloudfront_distribution" "static_distribution" 
{
  enabled             = "${var.enabled}"
  is_ipv6_enabled     = "${var.is_ipv6_enabled}"
  comment             = "${format("%s static content", var.comment)}"
  default_root_object = "${var.default_root_object}"
  price_class         = "${var.price_class}"
  web_acl_id          = "${var.web_acl_id}"
  aliases             = ["${var.alias}"]

  origin 
  {
    origin_id   = "S3Bucket"
    origin_path = "/${terraform.workspace}/build"
    domain_name = "${var.alias}.s3.amazonaws.com"
    s3_origin_config 
    {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
    }
  }

    custom_error_response = {
    error_caching_min_ttl = 0
    error_code            = 400
    response_code         = 200
    response_page_path    = "/index.html"
  }

  custom_error_response = {
    error_caching_min_ttl = 0
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
  }

  custom_error_response = {
    error_caching_min_ttl = 0
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
  }

  custom_error_response = {
    error_caching_min_ttl = 0
    error_code            = 405
    response_code         = 200
    response_page_path    = "/index.html"
  }

  custom_error_response = {
    error_caching_min_ttl = 0
    error_code            = 414
    response_code         = 200
    response_page_path    = "/index.html"
  }

  custom_error_response = {
    error_caching_min_ttl = 0
    error_code            = 416
    response_code         = 200
    response_page_path    = "/index.html"
  }

  custom_error_response = {
    error_caching_min_ttl = 0
    error_code            = 500
    response_code         = 200
    response_page_path    = "/index.html"
  }

  custom_error_response = {
    error_caching_min_ttl = 0
    error_code            = 501
    response_code         = 200
    response_page_path    = "/index.html"
  }

  custom_error_response = {
    error_caching_min_ttl = 0
    error_code            = 502
    response_code         = 200
    response_page_path    = "/index.html"
  }

  custom_error_response = {
    error_caching_min_ttl = 0
    error_code            = 503
    response_code         = 200
    response_page_path    = "/index.html"
  }

  custom_error_response = {
    error_caching_min_ttl = 0
    error_code            = 504
    response_code         = 200
    response_page_path    = "/index.html"
  }

  default_cache_behavior {
    allowed_methods  = "${var.allowed_methods}"
    cached_methods   = "${var.cached_methods}"
    target_origin_id = "S3Bucket"

    forwarded_values 
    {
      query_string = "${var.query_string}"
      cookies 
      {
        forward = "${var.forward_cookies}"
      }
    }

    viewer_protocol_policy = "${var.viewer_protocol_policy}"

    default_ttl = "0"
    min_ttl     = "0"
    max_ttl     = "0"
    compress    = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "${var.geo_restriction_type}"
    }
  }

  tags {
    CostCenter  = "${var.costcenter}"
    Environment = "${var.environment}"
    Service     = "${var.service}"
    Repo_Name   = "${var.repo_name}"
  }


   viewer_certificate {
     acm_certificate_arn            = "${aws_acm_certificate.cert.arn}"
     minimum_protocol_version       = "${var.viewer_minimum_protocol_version}"
     cloudfront_default_certificate = "${var.cloudfront_default_certificate}"
     ssl_support_method             = "${var.ssl_support_method}"
     iam_certificate_id             = "${var.iam_certificate_id}"
  }

  http_version = "${var.http_version}"
}

# Create the AWS route 53 record for cloudfront

resource "aws_route53_record" "main_record" 
{
  zone_id = "${var.hosted_zone_id}"
  name = "${var.route53_record_name}.${var.domain_name}"
  type = "A"
  alias 
  {
    name = "${aws_cloudfront_distribution.static_distribution.domain_name}"
    zone_id = "${aws_cloudfront_distribution.static_distribution.hosted_zone_id}"
    evaluate_target_health = false
  }
}
