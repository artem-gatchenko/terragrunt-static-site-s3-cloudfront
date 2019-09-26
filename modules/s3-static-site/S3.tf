provider "aws" {
  alias = "bucket"
  region = var.s3_bucket_region
}

resource "aws_s3_bucket" "s3" {
  provider      = "aws.bucket"
  bucket        = var.s3_bucket_name
  acl           = "private"
  force_destroy = true

  tags = {
    Name = var.s3_bucket_name
  }
}