## Data Sources

data "aws_iam_policy_document" "ih-tf-aws-control-assume" {
  statement {
    sid     = "000"
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::990466748045:user/aleks"
      ]
    }
  }
}

## EOF Data Sources


# IAM role ih-tf-terraform-control

resource "aws_iam_role" "ih-tf-aws-control" {
  provider           = aws.aws-289256138624-uw1
  name               = "ih-tf-aws-control"
  description        = "Role to manage the main AWS account 99046674804 with Terraform"
  assume_role_policy = data.aws_iam_policy_document.ih-tf-aws-control-assume.json
}

resource "aws_iam_role_policy_attachment" "ih-tf-aws-control" {
  provider   = aws.aws-289256138624-uw1
  policy_arn = data.aws_iam_policy.administrator-access.arn
  role       = aws_iam_role.ih-tf-aws-control.name
}
