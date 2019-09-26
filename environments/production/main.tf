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
  region = "${var.production_s3_bucket_region}"
}

module "s3-static-site" {
  source             = "../../modules/s3-static-site"
  s3_bucket_region   = var.production_s3_bucket_region
  zone_id            = var.production_zone_id
  domain_name        = var.production_domain_name
  s3_bucket_name     = var.production_s3_bucket_name
  s3_bucket_iam_user = var.production_iam_user
}

output "S3_Bucket" { value = module.s3-static-site.S3_Bucket}
output "S3_Region" { value = module.s3-static-site.S3_Region }
output "Distribution_ID" { value = module.s3-static-site.Distribution_ID }
output "Access_Key" { value = module.s3-static-site.Access_Key }
output "Secret_Key" { value = module.s3-static-site.Secret_Key }