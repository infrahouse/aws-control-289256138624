variable "gha_role_arn" {
  description = "Role that assumes a GitHub Actions worker"
  type        = string
}

variable "name" {
  description = "Role name"
}
variable "read_only_permissions" {
  description = "Whether the role should have read-only permissions on the state bucket. It's needed for roles that access the state via terraform_remote_state data source."
  type        = bool
  default     = false
}

variable "state_bucket" {
  description = "Name of the S3 bucket with the state"
}

variable "state_key" {
  description = "Path to the state file in the state bucket"
  type        = string
  default     = "terraform.tfstate"
}

variable "terraform_locks_table_arn" {
  description = "DynamoDB table that holds Terraform state locks."
}
