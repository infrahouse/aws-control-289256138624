# Roles for CI/CD in the aws-control-289256138624 repo

module "ih-tf-aws-control-289256138624-admin" {
  source = "github.com/infrahouse/terraform-aws-gha-admin"
  providers = {
    aws = aws.aws-289256138624-uw1
  }
  gh_identity_provider_arn = aws_iam_openid_connect_provider.github.arn
  repo_name                = "aws-control-289256138624"
  state_bucket             = "infrahouse-aws-control-289256138624"
}

module "ih-tf-aws-control-289256138624-state-manager" {
  source = "./modules/state-manager-role"
  providers = {
    aws = aws.aws-289256138624-uw1
  }
  name                      = "ih-tf-aws-control-289256138624-state-manager"
  gha_role_arn              = module.ih-tf-aws-control-289256138624-admin.gha_role_arn
  state_bucket              = "infrahouse-aws-control-289256138624"
  terraform_locks_table_arn = aws_dynamodb_table.terraform_locks.arn
}
