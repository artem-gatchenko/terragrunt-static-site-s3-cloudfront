### DEVELOPMENT ENVIRONMENT ####

variable "development_s3_bucket_name" {}
variable "development_s3_bucket_region" {}
variable "development_zone_id" {}
variable "development_domain_name" {}
variable "development_iam_user" {}

######### END OF BLOCK #########

##### STAGING ENVIRONMENT ######

variable "staging_s3_bucket_name" {}
variable "staging_s3_bucket_region" {}
variable "staging_zone_id" {}
variable "staging_domain_name" {}
variable "staging_iam_user" {}

######### END OF BLOCK #########

#### PRODUCTION ENVIRONMENT ####

variable "production_s3_bucket_name" {}
variable "production_s3_bucket_region" {}
variable "production_zone_id" {}
variable "production_domain_name" {}
variable "production_iam_user" {}

######### END OF BLOCK #########