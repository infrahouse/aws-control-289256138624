## Data Sources

data "aws_iam_policy_document" "ih-tf-terraform-control-assume" {
  statement {
    sid     = "000"
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::990466748045:user/aleks",
        "arn:aws:iam::303467602807:role/ih-tf-github-control-github"
      ]
    }
  }
}

## EOF Data Sources


# IAM role ih-tf-terraform-control

resource "aws_iam_role" "ih-tf-terraform-control" {
  provider           = aws.aws-289256138624-uw1
  name               = "ih-tf-terraform-control"
  description        = "Role to manage 289256138624 with Terraform"
  assume_role_policy = data.aws_iam_policy_document.ih-tf-terraform-control-assume.json
}

resource "aws_iam_role_policy_attachment" "ih-tf-terraform-control" {
  provider   = aws.aws-289256138624-uw1
  policy_arn = data.aws_iam_policy.administrator-access.arn
  role       = aws_iam_role.ih-tf-terraform-control.name
}
