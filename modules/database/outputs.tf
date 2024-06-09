output "private_ip_address" {
  value       = tencentcloud_mysql_instance.default.intranet_ip
  description = "The private IP address of the SQL database instance."
}

output "database_name" {
  value = tencentcloud_mysql_database.default.db_name
}

output "username" {
  value = tencentcloud_mysql_account.default.name
}

output "password" {
  value = tencentcloud_mysql_account.default.password
}