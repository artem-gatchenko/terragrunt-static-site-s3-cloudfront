resource "aws_iam_user" "user" {
  name = "${var.s3_bucket_iam_user}"
  path = "/system/"
}

resource "aws_iam_access_key" "user" {
  user = "${aws_iam_user.user.name}"
}