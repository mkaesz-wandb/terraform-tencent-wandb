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