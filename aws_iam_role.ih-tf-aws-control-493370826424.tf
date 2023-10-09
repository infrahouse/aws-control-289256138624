# Roles for CI/CD in the aws-control-493370826424 repo

module "ih-tf-aws-control-493370826424-state-manager" {
  source  = "infrahouse/state-manager/aws"
  version = "~> 0.1"
  providers = {
    aws = aws.aws-289256138624-uw1
  }
  name = "ih-tf-aws-control-${local.aws_account_id.management}-state-manager"
  assuming_role_arns = [
    "arn:aws:iam::${local.aws_account_id.management}:role/ih-tf-aws-control-${local.aws_account_id.management}-github",
    local.me_arn
  ]
  state_bucket              = "infrahouse-aws-control-${local.aws_account_id.management}"
  terraform_locks_table_arn = aws_dynamodb_table.terraform_locks.arn
}
