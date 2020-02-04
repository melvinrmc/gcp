data "google_container_cluster" "my_cluster" {
  name     = google_container_cluster.primary.name
  location = var.MY_REGION
}

output "cluster_username" {
  value = data.google_container_cluster.my_cluster.master_auth[0].username
}

output "cluster_password" {
  value = data.google_container_cluster.my_cluster.master_auth[0].password
}

output "client_certificate" {
  value = data.google_container_cluster.my_cluster.master_auth[0].client_certificate
}

output "client_key" {
  value = data.google_container_cluster.my_cluster.master_auth[0].client_key
}

output "endpoint" {
  value = data.google_container_cluster.my_cluster.endpoint
}

output "instance_group_urls" {
  value = data.google_container_cluster.my_cluster.instance_group_urls
}

output "node_config" {
  value = data.google_container_cluster.my_cluster.node_config
}

output "node_pools" {
  value = data.google_container_cluster.my_cluster.node_pool
}
