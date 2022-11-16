# create an S3 bucket to store the FE code

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name}"
  acl    = "${var.acl}"
  region = "${var.region}"

  tags {
    CostCenter = "12345"
    Repo_Name  = "TFRepo"
  }

}

data "aws_iam_policy_document" "s3_policy" 
{
  policy_id = "PolicyForCloudFrontPrivateContent"
  statement 
  {
    sid       = "${lower(format("demo-%s-cloudfront", terraform.workspace))}"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.bucket.arn}/*","${aws_s3_bucket.bucket.arn}"]

    principals 
    {
      type        = "AWS"
      identifiers = ["${var.cloudfront_access_identity}"]
    }
  }
}

resource "aws_s3_bucket_policy" "bucket" 
{
  bucket = "${aws_s3_bucket.bucket.id}"
  policy = "${data.aws_iam_policy_document.s3_policy.json}"
}
