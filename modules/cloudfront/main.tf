# Cloudfront Origin Access Identity
resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = var.bucket_name
}

# Cloudfront Distribution (without www)
resource "aws_cloudfront_distribution" "website_distribution" {
    origin {
        domain_name = var.bucket_regional_domain_name
        origin_id = var.bucket_name
        s3_origin_config {
            origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
        }
    }

    enabled = true
    is_ipv6_enabled = true
    comment = var.distribution_comment
    default_root_object = "index.html"

    aliases = [
        var.domain_name
    ]

    default_cache_behavior {
        allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = var.bucket_name

        forwarded_values {
            query_string = false

            cookies {
                forward = "none"
            }
        }

        viewer_protocol_policy = "redirect-to-https"
        min_ttl = 0
        default_ttl = 3600
        max_ttl = 86400
    }

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

    viewer_certificate {
        acm_certificate_arn = var.certificate_arn
        ssl_support_method = "sni-only"
    }

    custom_error_response {
      error_code = "400"
      error_caching_min_ttl = 300
      response_code = "200"
      response_page_path = "/index.html"
    }

    custom_error_response {
      error_code = "403"
      error_caching_min_ttl = 300
      response_code = "200"
      response_page_path = "/index.html"
    }

    custom_error_response {
      error_code = "404"
      error_caching_min_ttl = 300
      response_code = "200"
      response_page_path = "/index.html"
    }
}

resource "aws_route53_record" "website_dns_record" {
    name = var.domain_name
    type = "A"
    zone_id = var.principal_domain_zone_id

    alias {
        evaluate_target_health = false
        name = aws_cloudfront_distribution.website_distribution.domain_name
        zone_id = aws_cloudfront_distribution.website_distribution.hosted_zone_id
    }
}