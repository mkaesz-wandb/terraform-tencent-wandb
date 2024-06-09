output "vpc" {
  value       = tencentcloud_vpc.vpc.id
  description = "The network."
}

output "subnet" {
  value = tencentcloud_subnet.subnet.id
  description = "The subnetwork."
}