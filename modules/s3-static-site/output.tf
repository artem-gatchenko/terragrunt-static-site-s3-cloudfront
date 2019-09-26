output "S3_Bucket" { value = aws_s3_bucket.s3.id }
output "S3_Region" { value = var.s3_bucket_region }
output "Distribution_ID" { value = aws_cloudfront_distribution.cf_distr.id }
output "Access_Key" { value = aws_iam_access_key.user.id }
output "Secret_Key" { value = aws_iam_access_key.user.secret }