output "kubeconfig" {
  value     = tencentcloud_kubernetes_cluster.default.kube_config
  sensitive = true
}

output "cluster_endpoint" {
  sensitive = true
  value     = tencentcloud_kubernetes_cluster.default.pgw_endpoint
}
