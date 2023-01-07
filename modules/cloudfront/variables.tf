variable "bucket_name" {
    description = "Nombre del bucket S3"
}

variable "distribution_comment" {
    description = "Comentario de la distribucion CDN en Cloudfront"
}

variable "domain_name" {
    description = "Nombre del dominiode la aplicación"
}

variable "certificate_arn" {
    description = "ARN de certificado ARN"
}

variable "principal_domain_zone_id" {
    description = "Zone ID del dominio principal"
}

variable "bucket_regional_domain_name" {
    description = "Nombre del dominio (regional) del bucket S3"
}
