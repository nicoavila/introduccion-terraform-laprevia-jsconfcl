# Una gentil introducción a Terraform en AWS para Frontends
> Charla para #LaPrevia de JSConf CL

## Herramientas necesarias
* Cuenta de AWS
* awscli
* Terraform >v1.2.8

## Instrucciones
* Clonar el repositorio
* Renombrar archivo llamado `prod.tfvars.sample` a `prod.tfvars.sample`
* Ejecutar `terraform init`
* Ejecutar `terraform plan --var-file="prod.tfvars"`
* Ejecutar `terraform apply --var-file="prod.tfvars"`