data "tencentcloud_availability_zones_by_product" "zones" {
  product = "cdb"
}

resource "tencentcloud_security_group" "security_group" {
  name        = "${var.namespace}-sg-mysql"
  description = "Security Group for W&B"
}

resource "random_string" "master_password" {
  length  = 32
  special = false
}

resource "random_pet" "mysql" {
  length = 2
}

locals {
  database_name = "wandb_local"

  master_username = "wandb"
  master_password = random_string.master_password.result

  master_instance_name = "${var.namespace}-${random_pet.mysql.id}"
}

resource "tencentcloud_mysql_instance" "default" {
  engine_version    = "8.0"
  root_password     = local.master_password
  availability_zone = data.tencentcloud_availability_zones_by_product.zones.zones.0.name
  instance_name     = local.master_instance_name
  mem_size          = 4000
  volume_size       = 200
  vpc_id            = var.vpc
  subnet_id         = var.subnet
  intranet_port     = 3306
  security_groups   = [tencentcloud_security_group.security_group.id]
}

resource "tencentcloud_mysql_database" "default" {
  instance_id        = tencentcloud_mysql_instance.default.id
  db_name            = local.database_name
  character_set_name = "utf8"
}

resource "tencentcloud_mysql_account" "default" {
  mysql_id             = tencentcloud_mysql_instance.default.id
  name                 = local.master_username
  password             = local.master_password
  description          = "WandB User"
}