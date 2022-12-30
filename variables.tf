variable "enforce_domain_name" {
  default     = "priya-chainguard.dev"
  type        = string
  description = "Domain name of your Chainguard Enforce environment"
  sensitive   = false
  nullable    = false
}

variable "enforce_group_id" {
  type        = string
  description = "Enforce IAM group ID to bind your AWS account to"
  sensitive   = false
  nullable    = false
  default     = "20c1263ac49f8cf9ad39e91006fa2beb8096e7f4"

  validation {
    condition     = length(regexall("^[a-f0-9]{40}(\\/[a-f0-9]{16})*$", var.enforce_group_id)) == 1
    error_message = "The enforce_group_id must be a valid group id."
  }
}

variable "google_project_id" {
  default     = "priya-chainguard"
  type        = string
  description = "GCP Project ID. If not set, will default to provider default project id"
  sensitive   = false
  nullable    = false
}
