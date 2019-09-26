resource "aws_iam_user_policy" "s3" {
  name = "S3-FullAccess-${var.s3_bucket_name}"
  user = "${aws_iam_user.user.name}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "1",
            "Effect": "Allow",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::arn:aws:s3:::${aws_s3_bucket.s3.bucket}/*"
        },
        {
            "Sid": "2",
            "Effect": "Allow",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::/arn:aws:s3:::${aws_s3_bucket.s3.bucket}/*"
        },
        {
            "Sid": "3",
            "Effect": "Allow",
            "Action": [
                "s3:PutAccountPublicAccessBlock",
                "s3:GetAccountPublicAccessBlock",
                "s3:ListAllMyBuckets",
                "s3:HeadBucket"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor3",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.s3.bucket}/*",
                "arn:aws:s3:::${aws_s3_bucket.s3.bucket}"
            ]
        }
    ]
}
EOF
}

resource "aws_s3_bucket_policy" "s3" {
  provider      = "aws.bucket"
  bucket        = "${aws_s3_bucket.s3.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AddPerm",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_user.user.arn}"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.s3.bucket}/*"
    },
    {
      "Sid": "1",
      "Effect": "Allow",
      "Principal": {
          "AWS": "${aws_iam_user.user.arn}"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.s3.bucket}/*"
    },
    {
      "Sid": "2",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.s3.bucket}/*"
    }
  ]
}
EOF
}
