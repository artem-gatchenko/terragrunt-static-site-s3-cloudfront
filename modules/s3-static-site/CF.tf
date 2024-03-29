resource "aws_cloudfront_distribution" "cf_distr" {
  origin {
    domain_name = "${aws_s3_bucket.s3.bucket_domain_name}"
    origin_id   = "${aws_s3_bucket.s3.bucket}"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
    }

  }

  enabled             = true
  is_ipv6_enabled     = false
  comment             = ""
  default_root_object = "index.html"

  custom_error_response {
    error_caching_min_ttl = 300
    error_code = 403
    response_code = 200
    response_page_path = "/index.html"
  }

  custom_error_response {
    error_caching_min_ttl = 300
    error_code = 404
    response_code = 200
    response_page_path = "/index.html"
  }

  aliases = ["${var.domain_name}"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS", "PUT", "PATCH", "POST", "DELETE"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${aws_s3_bucket.s3.bucket}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${aws_acm_certificate.cert_cdn.arn}"
    minimum_protocol_version = "TLSv1.1_2016"
    ssl_support_method = "sni-only"
  }

  depends_on = ["aws_acm_certificate_validation.cert_cdn"]
}


resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "access-identity-${aws_s3_bucket.s3.bucket_domain_name}"
}