locals {
  home_account_id = local.aws_account_id.terraform-control
  aws_account_id = {
    control : "990466748045"
    terraform-control : "289256138624"
    ci-cd : "303467602807"
    management : "493370826424"
  }
  me_arn = "arn:aws:iam::990466748045:user/aleks"
}
