resource "aws_acm_certificate" "cert_cdn" {
  domain_name = "${var.domain_name}"
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "cert_cdn" {
  certificate_arn = "${aws_acm_certificate.cert_cdn.arn}"
  validation_record_fqdns = ["${aws_route53_record.cert_cdn.fqdn}"]
}