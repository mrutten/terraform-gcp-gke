/******************************************
	Provider configuration
 *****************************************/
provider "google" {
  project = var.project_id
  region  = var.region
}

/******************************************
	Project configuration
 *****************************************/
resource "google_project" "project" {
  name       = var.project_name
  project_id = var.project_id

  auto_create_network = false
  billing_account     = var.billing_account
  folder_id           = null
  org_id              = var.org_id
}

/******************************************
	Service configuration
 *****************************************/
module "host-project-services" {
  source     = "../../modules/project_services"
  project_id = var.host_project_id
  activate_apis = [
    "container.googleapis.com",
  ]
}

module "project-services" {
  source     = "../../modules/project_services"
  project_id = var.project_id
  activate_apis = [
    "container.googleapis.com",
    "iam.googleapis.com",
  ]
}

/******************************************
	GKE cluster configuration
 *****************************************/
data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

data "google_compute_subnetwork" "subnetwork" {
  project = var.host_project_id
  name    = var.subnetwork
  region  = var.region
}

module "gke" {
  source                     = "../../modules/private-cluster/"
  project_id                 = var.project_id
  project_number             = google_project.project.number
  network_project_id         = var.host_project_id
  name                       = var.cluster_name
  regional                   = false
  region                     = var.region
  zones                      = var.zones
  network                    = var.network
  subnetwork                 = var.subnetwork
  ip_range_pods              = var.ip_range_pods
  ip_range_services          = var.ip_range_services
  create_service_account     = true
  service_account_name       = var.service_account_name
  enable_private_endpoint    = true
  enable_private_nodes       = true
  master_ipv4_cidr_block     = var.master_ipv4_cidr_block
  master_authorized_networks = var.master_authorized_networks
  remove_default_node_pool   = var.remove_default_node_pool
  node_pools                 = var.node_pools
}
