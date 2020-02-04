
variable "MY_GCP_CREDENTIALS" {
  type = string  
}

variable "MY_PROJECT_ID" {
  type = string  
}

variable "MY_REGION" {
  type = string  
}

provider "google" {
  credentials = var.MY_GCP_CREDENTIALS
  project     = var.MY_PROJECT_ID
  region      = var.MY_REGION
}


resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = var.MY_REGION

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = var.MY_REGION
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
