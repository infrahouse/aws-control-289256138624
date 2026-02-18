# Roles for CI/CD in the infrahouse-website-infra repo

module "ih-tf-infrahouse-website-infra-state-manager" {
  source  = "infrahouse/state-manager/aws"
  version = "~> 1.0"
  providers = {
    aws = aws.aws-289256138624-uw1
  }
  name                      = "ih-tf-infrahouse-website-infra-state-manager"
  state_bucket              = "infrahouse-website-infra"
  terraform_locks_table_arn = aws_dynamodb_table.terraform_locks.arn
  assuming_role_arns = [
    "arn:aws:iam::${local.aws_account_id.management}:role/ih-tf-infrahouse-website-infra-github",
    local.aws_control_admin_arn,
    local.me_arn
  ]
}
