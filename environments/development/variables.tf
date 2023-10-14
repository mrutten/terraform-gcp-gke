variable "billing_account" {
  description = "The ID of the billing account."
  type        = string
}
variable "org_id" {
  description = "The ID of the organisation."
  type        = number
}

variable "host_project_id" {
  description = "The ID of the host project."
  type        = string
}

variable "project_id" {
  description = "The ID of the project where this GKE cluster will be created."
  type        = string
}

variable "project_name" {
  description = "The name of the project where this GKE cluster will be created."
  type        = string
}

variable "region" {
  description = "The region to deploy to."
  type        = string
}

variable "zones" {
  description = "The zone to host the cluster in (required if is a zonal cluster)."
  type        = list(string)
}

variable "network" {
  description = "The VPC network to host the cluster in."
}

variable "subnetwork" {
  description = "The subnetwork to host the cluster in."
}

variable "add_cluster_firewall_rules" {
  description = "Create additional firewall rules."
  type        = bool
  default     = true
}

variable "master_ipv4_cidr_block" {
  description = "Master IP CIDR block"
  type        = string
}

variable "cluster_name" {
  description = "The cluster name"
  default     = "gke"
}

variable "initial_node_count" {
  description = "The number of nodes to create in this cluster's default node pool."
  type        = number
  default     = 1
}

variable "remove_default_node_pool" {
  description = "Remove default node pool while setting up the cluster."
  type        = bool
  default     = true
}

variable "ip_range_pods" {
  description = "The secondary ip range to use for pods"
}

variable "ip_range_services" {
  description = "The secondary ip range to use for services"
}

variable "service_account_name" {
  description = "Service account to associate to the nodes in the cluster"
  type        = string
}

variable "master_authorized_networks" {
  description = <<-EOF
    List of master authorized networks. 
    If none are provided, disallow external access (except the cluster node IPs, which GKE automatically whitelists).
  EOF
  type = list(object({
    cidr_block   = string
    display_name = string
  }))
  default = []
}

variable "node_pools" {
  description = "List of maps containing node pools."
  type        = list(map(any))

  default = [
    {
      name = "default-node-pool"
    },
  ]
}

variable "node_pools_oauth_scopes" {
  description = "Map of lists containing node oauth scopes by node-pool name."
  type        = map(list(string))

  # Default is being set in variables_defaults.tf
  default = {
    all               = ["https://www.googleapis.com/auth/cloud-platform"]
    default-node-pool = []
  }
}

variable "node_pools_labels" {
  description = "Map of maps containing node labels by node-pool name."
  type        = map(map(string))

  # Default is being set in variables_defaults.tf
  default = {
    all               = {}
    default-node-pool = {}
  }
}

variable "node_pools_metadata" {
  description = "Map of maps containing node metadata by node-pool name."
  type        = map(map(string))

  # Default is being set in variables_defaults.tf
  default = {
    all               = {}
    default-node-pool = {}
  }
}

variable "node_pools_taints" {
  description = "Map of lists containing node taints by node-pool name."
  type        = map(list(object({ key = string, value = string, effect = string })))

  # Default is being set in variables_defaults.tf
  default = {
    all               = []
    default-node-pool = []
  }
}

variable "node_pools_tags" {
  description = "Map of lists containing node network tags by node-pool name."
  type        = map(list(string))

  # Default is being set in variables_defaults.tf
  default = {
    all               = []
    default-node-pool = []
  }
}
