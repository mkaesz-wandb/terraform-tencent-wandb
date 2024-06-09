output "network" {
  value       = tencentcloud_vpc.vpc
  description = "The network."
}

output "subnetwork" {
  value = tencentcloud_subnet.subnet

  description = "The subnetwork."
}