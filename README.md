# Terraform environment for deploying Front End infrastructure in AWS

This repository contains 
- Generic terraform modules required to create 
  - Cloudfront resource
  - S3 bucket

Terraform will deploy from Jenkins.

Prerequisite

- AWS access key and AWS secret key should be added in Jenkins as a Credentials with below name.
  access_key_tf
  secret_access_key_tf

- Backend S3 bucket for terraform state file.

- Dyanmo DB table for state lock table.

- Terraform version should be 0.11.4 in your Jenkins slave 
