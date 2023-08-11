# Roles for CI/CD in the aws-control-303467602807 repo

module "ih-tf-aws-control-303467602807-state-manager" {
  source = "./modules/state-manager-role"
  providers = {
    aws = aws.aws-289256138624-uw1
  }
  name = "ih-tf-aws-control-${local.aws_account_id.ci-cd}-state-manager"
  assuming_role_arns = [
    "arn:aws:iam::${local.aws_account_id.ci-cd}:role/ih-tf-aws-control-${local.aws_account_id.ci-cd}-github",
    local.me_arn
  ]
  state_bucket              = "infrahouse-aws-control-${local.aws_account_id.ci-cd}"
  terraform_locks_table_arn = aws_dynamodb_table.terraform_locks.arn
}

module "ih-tf-aws-control-303467602807-state-manager-read-only" {
  source = "./modules/state-manager-role"
  providers = {
    aws = aws.aws-289256138624-uw1
  }
  name = "ih-tf-aws-control-${local.aws_account_id.ci-cd}-state-manager-read-only"
  assuming_role_arns = [
    "arn:aws:iam::${local.aws_account_id.management}:role/ih-tf-aws-control-${local.aws_account_id.management}-admin",
    local.me_arn
  ]
  state_bucket              = "infrahouse-aws-control-${local.aws_account_id.ci-cd}"
  terraform_locks_table_arn = aws_dynamodb_table.terraform_locks.arn
  read_only_permissions     = true
}
