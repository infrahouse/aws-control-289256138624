# Roles for CI/CD in the aws-control-289256138624 repo

module "ih-tf-aws-control-289256138624-admin" {
  source  = "infrahouse/gha-admin/aws"
  version = "~> 1.0, >= 1.0.1"
  providers = {
    aws = aws.aws-289256138624-uw1
  }
  gh_identity_provider_arn = module.github-connector.gh_openid_connect_provider_arn
  repo_name                = "aws-control-${local.aws_account_id.terraform-control}"
  state_bucket             = "infrahouse-aws-control-${local.aws_account_id.terraform-control}"
  gh_org_name              = "infrahouse"
  admin_allowed_arns = [
    local.me_arn
  ]
}

module "ih-tf-aws-control-289256138624-state-manager" {
  source  = "infrahouse/state-manager/aws"
  version = "~> 0.1"
  providers = {
    aws = aws.aws-289256138624-uw1
  }
  name = "ih-tf-aws-control-${local.aws_account_id.terraform-control}-state-manager"
  assuming_role_arns = [
    module.ih-tf-aws-control-289256138624-admin.github_role_arn,
    local.me_arn
  ]
  state_bucket              = "infrahouse-aws-control-${local.aws_account_id.terraform-control}"
  terraform_locks_table_arn = aws_dynamodb_table.terraform_locks.arn
}

module "ih-tf-aws-control-289256138624-state-manager-tmp" {
  source  = "infrahouse/state-manager/aws"
  version = "~> 0.1"
  providers = {
    aws = aws.aws-289256138624-uw1
  }
  name = "ih-tf-aws-control-${local.aws_account_id.terraform-control}-state-manager-tmp"
  assuming_role_arns = [
    module.ih-tf-aws-control-289256138624-admin.github_role_arn,
    local.me_arn
  ]
  state_bucket              = "infrahouse-aws-control-${local.aws_account_id.terraform-control}"
  terraform_locks_table_arn = aws_dynamodb_table.terraform_locks.arn
}
