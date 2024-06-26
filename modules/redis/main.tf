data "tencentcloud_redis_zone_config" "zone" {
  type_id = 7
}

resource "tencentcloud_redis_instance" "default" {
  availability_zone  = data.tencentcloud_redis_zone_config.zone.list[0].zone
  type_id            = data.tencentcloud_redis_zone_config.zone.list[0].type_id
  mem_size           = 8192
  redis_shard_num    = data.tencentcloud_redis_zone_config.zone.list[0].redis_shard_nums[0]
  redis_replicas_num = data.tencentcloud_redis_zone_config.zone.list[0].redis_replicas_nums[0]
  name               = "${var.namespace}-redis"
  port               = 6379
  vpc_id             = var.vpc
  subnet_id          = var.subnet
}

resource "tencentcloud_redis_ssl" "ssl" {
  instance_id = tencentcloud_redis_instance.default.id
  ssl_config  = "enabled"
}

resource "tencentcloud_redis_account" "account" {
  instance_id      = tencentcloud_redis_instance.default.id
  account_name     = "wandb"
  account_password = "wandb"
  remark           = "master"
  readonly_policy  = ["master"]
  privilege        = "rw"
}