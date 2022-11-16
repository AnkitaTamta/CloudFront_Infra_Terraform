variable "http_version" {
  default = ""
}

variable "alias" {
  default = ""
}

variable "bucket_name" {
  default = ""
}

variable "enabled" {
  default = ""
}

variable "origin_access_identity_comment" {
  default = ""
}

variable "is_ipv6_enabled" {
  default = ""
}

variable "price_class" {
  default = ""
}

variable "comment" {
  default = ""
}

variable "default_root_object" {
  default = ""
}

variable "log_include_cookies" {
  default = ""
}

variable "log_bucket" {
  default = ""
}

variable "log_prefix" {
  default = ""
}

variable "web_acl_id" {
  default = ""
}

variable "allowed_methods" {
  type    = "list"
  default = []
}

variable "cached_methods" {
  type    = "list"
  default = []
}

variable "query_string" {
  default = ""
}

variable "forward_cookies" {
  default = ""
}

variable "viewer_protocol_policy" {
  default = ""
}

variable "min_ttl" {
  default = ""
}

variable "default_ttl" {
  default = ""
}

variable "max_ttl" {
  default = ""
}

variable "geo_restriction_type" {
  default = ""
}

variable "costcenter" {
  default = ""
}

variable "environment" {
  default = ""
}

variable "service" {
  default = ""
}

variable "repo_name" {
  default = ""
}

variable "viewer_minimum_protocol_version" {
  default = ""
}

variable "cloudfront_default_certificate" {
  default = ""
}

variable "ssl_support_method" {
  default = ""
}

variable "iam_certificate_id" {
  default = ""
}

variable "api_endpoint" {
  default = ""
}

variable hosted_zone_id {
  default = ""
}

variable domain_name {
  default = ""
}

variable route53_record_name {
	default = ""
}

variable alias_zone_id {
	default = ""
}
