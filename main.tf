# DNS
module "route_53" {
    source = "./modules/route53"

    principal_domain = "keycat.store"
    principal_domain_comment = "Dominio de tienda Keycat.store"   
}

# S3
module "s3" {
    source = "./modules/s3"

    bucket_name = var.bucket_name
}

# ACM
module "acm" {
    source = "./modules/acm"

    principal_certificate_domain_name = "keycat.store"
    principal_domain_zone_id = module.route_53.principal_domain_zone_id

    depends_on = [
      module.route_53
    ]
}

# CLOUDFRONT
module "cloudfront" {
    source = "./modules/cloudfront"

    bucket_name = var.bucket_name
    distribution_comment = "Distribucion de tienda Keycat.store"
    domain_name = "keycat.store"
    certificate_arn = module.acm.principal_certificate_arn
    principal_domain_zone_id = module.route_53.principal_domain_zone_id
    bucket_regional_domain_name = module.s3.bucket_regional_domain_name

    depends_on = [
      module.route_53,
      module.s3,
      module.acm
    ]
}

