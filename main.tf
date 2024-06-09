terraform {
  required_providers {
    tencentcloud = {
      source = "tencentcloudstack/tencentcloud"
    }
  }
}

provider "tencentcloud" {
  region = var.region
}

module "storage" {
  source    = "./modules/storage"
  namespace = var.namespace
}

