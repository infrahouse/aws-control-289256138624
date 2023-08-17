# Roles for CI/CD in the infrahouse-website-infra repo

module "ih-tf-infrahouse-website-infra-state-manager" {
  source = "./modules/state-manager-role"
  providers = {
    aws = aws.aws-289256138624-uw1
  }
  name                      = "ih-tf-infrahouse-website-infra-state-manager"
  state_bucket              = "infrahouse-website-infra"
  terraform_locks_table_arn = aws_dynamodb_table.terraform_locks.arn
  assuming_role_arns = [
    module.buckets["infrahouse-website-infra"].remote_state.outputs.gha_role_arn,
    local.me_arn
  ]
}
