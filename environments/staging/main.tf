terraform {
  backend "s3" {}
  required_version = "~> 0.12.9"
}

provider "aws" {
  region  = "us-east-1"
  version = "~> 2.29"
}

provider "aws" {
  alias = "bucket"
  region = "${var.staging_s3_bucket_region}"
}

module "s3-static-site" {
  source             = "../../modules/s3-static-site"
  s3_bucket_region   = var.staging_s3_bucket_region
  zone_id            = var.staging_zone_id
  domain_name        = var.staging_domain_name
  s3_bucket_name     = var.staging_s3_bucket_name
  s3_bucket_iam_user = var.staging_iam_user
}