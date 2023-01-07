output "principal_certificate_arn" {
    value = aws_acm_certificate.principal_certificate.arn
    description = "ARN del certificado principal"
}

output "principal_certificate_validation_options" {
    value = aws_acm_certificate.principal_certificate.domain_validation_options
    description = "Opciones de validación para el certificado principal"
}