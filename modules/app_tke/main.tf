variable "default_instance_type" {
  default = "SA2.2XLARGE16"
}

resource "random_pet" "node_pool" {
  keepers = {
    machine_type = var.default_instance_type
  }
}

resource "tencentcloud_security_group" "sg" {
  name = "tf-example-np-sg"
}



resource "tencentcloud_kubernetes_cluster" "default" {
  vpc_id                  = var.vpc
  cluster_cidr            = "10.8.0.0/14"
  service_cidr            = "172.21.0.0/16"
  cluster_name            = "${var.namespace}-cluster"
  cluster_version         = "1.28"
  cluster_deploy_type     = "MANAGED_CLUSTER"
}

resource "tencentcloud_kubernetes_node_pool" "default" {
  name                     = "default-pool-${random_pet.node_pool.id}"
  cluster_id               = tencentcloud_kubernetes_cluster.default.id
  max_size                 = 2
  min_size                 = 2
  vpc_id                   = var.vpc
  subnet_ids               = [var.subnet]
  retry_policy             = "INCREMENTAL_INTERVALS"
  enable_auto_scale        = true
  multi_zone_subnet_policy = "EQUALITY"

  auto_scaling_config {
    instance_type              = var.default_instance_type
    system_disk_type           = "CLOUD_PREMIUM"
    system_disk_size           = "50"
    orderly_security_group_ids = [tencentcloud_security_group.sg.id]

    data_disk {
      disk_type = "CLOUD_PREMIUM"
      disk_size = 50
    }

    internet_charge_type       = "TRAFFIC_POSTPAID_BY_HOUR"
    internet_max_bandwidth_out = 10
    public_ip_assigned         = true
    password                   = "test123#"
    enhanced_security_service  = false
    enhanced_monitor_service   = false
    host_name                  = "12.123.0.0"
    host_name_style            = "ORIGINAL"
  }
}