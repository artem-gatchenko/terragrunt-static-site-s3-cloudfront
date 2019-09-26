resource "aws_route53_record" "s3" {
  name = "${var.domain_name}"
  type = "A"
  zone_id = "${var.zone_id}"

  alias {
    evaluate_target_health = false
    name = "${aws_cloudfront_distribution.cf_distr.domain_name}"
    zone_id = "${aws_cloudfront_distribution.cf_distr.hosted_zone_id}"
  }
}

resource "aws_route53_record" "cert_cdn" {
  name = "${aws_acm_certificate.cert_cdn.domain_validation_options.0.resource_record_name}"
  type = "${aws_acm_certificate.cert_cdn.domain_validation_options.0.resource_record_type}"
  zone_id = "${var.zone_id}"
  records = ["${aws_acm_certificate.cert_cdn.domain_validation_options.0.resource_record_value}"]
  ttl = 60
}
