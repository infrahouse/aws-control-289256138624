output "remote_state" {
  description = "Export the created state bucket as a data source"
  value       = data.terraform_remote_state.state
}
