variable "enforce_domain_name" {
  default     = "chainops.dev"
  type        = string
  description = "Domain name of your Chainguard Enforce environment"
  sensitive   = false
  nullable    = false
}

variable "github_actions_group_id" {
  default = "66fe2f6b69fb795e63abc2769c294ee0d049ee0a"
  type    = string
}

variable "enforce_group_id" {
  type        = string
  description = "DEPRECATED: Please use 'enforce_group_ids'. Enforce IAM group ID to bind your AWS account to"
  default     = ""
  sensitive   = false

  validation {
    condition     = var.enforce_group_id != "" ? length(regexall("^[a-f0-9]{40}(\\/[a-f0-9]{16})*$", var.enforce_group_id)) == 1 : true
    error_message = "The value 'enforce_group_id' must be a valid group id."
  }
}

variable "enforce_group_ids" {
  type        = list(string)
  description = "Enforce IAM group IDs to bind your AWS account to. If both 'enforce_group_id' and 'enforce_group_ids' are specified, 'enforce_group_id' is ignored."
  sensitive   = false
  default = ["b503e31b0dd075dbbcbc9b33f3476291d8e9b9a1",
    "20c1263ac49f8cf9ad39e91006fa2beb8096e7f4", // priya-chainguard.dev
    "587149645733a73d2dd182ac047b48d75464d7da", // james petersen
    "40d014119b67359f3cb069329889e9c7ea9fa0bf", // adam dawson
  "66fe2f6b69fb795e63abc2769c294ee0d049ee0a"]   // chainops.dev

  validation {
    condition     = can([for g in var.enforce_group_ids : regex("^[a-f0-9]{40}(\\/[a-f0-9]{16})*$", g)])
    error_message = "IDs in enforce_group_ids must be a valid group id."
  }
}

variable "google_project_id" {
  default     = "priya-chainguard"
  type        = string
  description = "GCP Project ID. If not set, will default to provider default project id"
  sensitive   = false
  nullable    = false
}


