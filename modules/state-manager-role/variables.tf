variable "gha_role_arn" {
  description = "Role that assumes a GitHub Actions worker"
  type        = string
}

variable "name" {
  description = "Role name"
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
