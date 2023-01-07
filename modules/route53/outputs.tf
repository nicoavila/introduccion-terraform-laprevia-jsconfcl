output "principal_domain_zone_id" {
    value = aws_route53_zone.principal_domain.zone_id
    description = "Zone ID del dominio principal"
}