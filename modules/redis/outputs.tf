output "connection_string" {
  value = "${tencentcloud_redis_instance.default.ip}:${tencentcloud_redis_instance.default.port}"
}



output "auth_string" {
  value = "${tencentcloud_redis_account.account.account_name}:${tencentcloud_redis_account.account.account_password}"
}

output "host" {
  value = tencentcloud_redis_instance.default.ip
}

output "port" {
  value = tencentcloud_redis_instance.default.port
}