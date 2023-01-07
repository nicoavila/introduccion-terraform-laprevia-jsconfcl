resource "aws_route53_zone" "principal_domain" {
    name = var.principal_domain
    comment = var.principal_domain_comment
}