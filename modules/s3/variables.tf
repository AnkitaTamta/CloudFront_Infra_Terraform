variable "bucket_name" {
  default = ""
}

variable "region" {
  default = ""
}

variable "acl" {
  default = ""
}

variable "cloudfront_access_identity" {
  default = ""
}

variable "kms_key"{
  description = "The KMS key ARN to use for default server-side encryption" 
  default = "arn:aws:kms:eu-central-1:XXXXXXXX:key/{{Key_name}}"
}
