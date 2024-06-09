module "storage" {
  source    = "./modules/storage"
  namespace = var.namespace
}

module "networking" {
  source     = "./modules/networking"
  namespace  = var.namespace
}

module "redis" {
  source    = "./modules/redis"
  namespace = var.namespace
  vpc           = module.networking.vpc
  subnet    =  module.networking.subnet
}

module "database" {
  source              = "./modules/database"
  namespace           = var.namespace
  vpc           = module.networking.vpc
  subnet    =  module.networking.subnet
}

module "app_tke" {
  source                   = "./modules/app_tke"
  namespace                = var.namespace
  vpc           = module.networking.vpc
  subnet    =  module.networking.subnet
}

locals {
  fqdn           = var.subdomain == null ? var.domain_name : "${var.subdomain}.${var.domain_name}"
  url            = "https://${local.fqdn}"
}

module "wandb" {
  source  = "wandb/wandb/helm"
  version = "1.2.0"

  spec = {
    values = {
      global = {
        host    = local.url
        license = var.license

        bucket = {
          provider = "gcs"
          name     = local.bucket
        }

        mysql = {
          name     = module.database.database_name
          user     = module.database.username
          password = module.database.password
          database = module.database.database_name
          host     = module.database.private_ip_address
          port     = 3306
        }

        redis = {
          password = module.redis[0].auth_string
          host     = module.redis[0].host
          port     = module.redis[0].port
          caCert   = module.redis[0].ca_cert
          params = {
            tls          = true
            ttlInSeconds = 604800
            caCertPath   = "/etc/ssl/certs/redis_ca.pem"
          }
        }
      }

      ingress = {
        nameOverride = var.namespace
        annotations = {
          "kubernetes.io/ingress.class"                 = "gce"
          "kubernetes.io/ingress.global-static-ip-name" = module.app_lb.address_operator_name
          "ingress.gcp.kubernetes.io/pre-shared-cert"   = module.app_lb.certificate
        }
      }

      redis = { install = false }
      mysql = { install = false }
    }
  }
}