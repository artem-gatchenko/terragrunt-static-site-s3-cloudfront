resource "aws_iam_user_policy" "cloudfront" {
  name = "CF-CreateInvalidation-${var.s3_bucket_name}"
  user = "${aws_iam_user.user.name}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:ListAllMyBuckets",
            "Resource": "arn:aws:s3:::${aws_s3_bucket.s3.bucket}"
        },
        {
            "Action": [
                "cloudfront:CreateInvalidation",
                "cloudfront:GetDistribution",
                "cloudfront:GetStreamingDistribution",
                "cloudfront:GetDistributionConfig",
                "cloudfront:GetInvalidation",
                "cloudfront:ListInvalidations",
                "cloudfront:ListStreamingDistributions",
                "cloudfront:ListDistributions"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
EOF
}