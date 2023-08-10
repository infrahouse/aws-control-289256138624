# Roles for CI/CD in the aws-control-289256138624 repo

module "ih-tf-aws-control-289256138624-admin" {
  source = "github.com/infrahouse/terraform-aws-gha-admin"
  providers = {
    aws = aws.aws-289256138624-uw1
  }
  gh_identity_provider_arn = module.github-connector.gh_openid_connect_provider_arn
  repo_name                = "aws-control-${local.aws_account_id.terraform-control}"
  state_bucket             = "infrahouse-aws-control-${local.aws_account_id.terraform-control}"
}

module "ih-tf-aws-control-289256138624-state-manager" {
  source = "./modules/state-manager-role"
  providers = {
    aws = aws.aws-289256138624-uw1
  }
  name                      = "ih-tf-aws-control-${local.aws_account_id.terraform-control}-state-manager"
  assuming_role_arn         = module.ih-tf-aws-control-289256138624-admin.gha_role_arn
  state_bucket              = "infrahouse-aws-control-${local.aws_account_id.terraform-control}"
  terraform_locks_table_arn = aws_dynamodb_table.terraform_locks.arn
}
