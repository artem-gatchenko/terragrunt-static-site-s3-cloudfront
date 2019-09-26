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
  region = "${var.development_s3_bucket_region}"
}

module "s3-static-site" {
  source             = "../../modules/s3-static-site"
  s3_bucket_region   = var.development_s3_bucket_region
  zone_id            = var.development_zone_id
  domain_name        = var.development_domain_name
  s3_bucket_name     = var.development_s3_bucket_name
  s3_bucket_iam_user = var.development_iam_user
}