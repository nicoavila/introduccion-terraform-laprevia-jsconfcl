output "s3_bucket" {
    description = "Nombre del bucket S3 que almacena la pagina"
    value = aws_s3_bucket.website_bucket.bucket
}

output "bucket_regional_domain_name" {
    description = "Nombre del dominio (regional) del bucket S3"
    value = aws_s3_bucket.website_bucket.bucket_regional_domain_name
}