variable "project_id" {
  description = "The GCP project you want to enable APIs on."
  type        = string
}

variable "enable_apis" {
  description = "Whether to actually enable the APIs. If false, this module is a no-op."
  type        = bool
  default     = true
}

variable "activate_apis" {
  description = "The list of apis to activate within the project."
  type        = list(string)
  default     = []
}

variable "activate_api_identities" {
  description = <<-EOF
    The list of service identities (Google Managed service account for the API) to force-create for the project (e.g. in order to grant additional roles).
    APIs in this list will automatically be appended to `activate_apis`.
    Not including the API in this list will follow the default behaviour for identity creation (which is usually when the first resource using the API is created).
    Any roles (e.g. service agent role) must be explicitly listed. 
    See https://cloud.google.com/iam/docs/understanding-roles#service-agent-roles-roles for a list of related roles.
  EOF
  type = list(object({
    api   = string
    roles = list(string)
  }))
  default = []
}

variable "disable_services_on_destroy" {
  description = "Whether project services will be disabled when the resources are destroyed."
  type        = bool
  default     = true
}

variable "disable_dependent_services" {
  description = "Whether services that are enabled and which depend on this service should also be disabled when this service is destroyed."
  type        = bool
  default     = true
}
