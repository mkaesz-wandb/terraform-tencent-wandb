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

provider "helm" {
  kubernetes {
    host                   = "https://${module.wandb.cluster_endpoint}"
    config_path            = module.wandb.kubeconfig
    token                  = data.google_client_config.current.access_token
  }
}

module "wandb" {
  source = "../../"

  namespace             = var.namespace
  license               = var.license
  domain_name           = var.domain_name
  subdomain             = var.subdomain
  region                = var.region
}

output "url" {
  value = module.wandb.url
}