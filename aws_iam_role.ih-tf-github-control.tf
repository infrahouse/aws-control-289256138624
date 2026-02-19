## Data Sources

data "aws_iam_policy_document" "ih-tf-github-control-assume" {
  statement {
    sid     = "000"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type = "Federated"
      identifiers = [
        "arn:aws:iam::289256138624:oidc-provider/token.actions.githubusercontent.com"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values = [
        "sts.amazonaws.com"
      ]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "repo:infrahouse8/github-control:*"
      ]
    }
  }
}

## EOF Data Sources


# IAM role ih-tf-github-control

resource "aws_iam_role" "ih-tf-github-control" {
  provider           = aws.aws-289256138624-uw1
  name               = "ih-tf-github-control"
  description        = "Terraform Applier for github-control repo"
  assume_role_policy = data.aws_iam_policy_document.ih-tf-github-control-assume.json
}

# TODO: GitHub user doesn't really need Admin permissions
resource "aws_iam_role_policy_attachment" "ih-tf-github-control" {
  provider   = aws.aws-289256138624-uw1
  policy_arn = data.aws_iam_policy.administrator-access.arn
  role       = aws_iam_role.ih-tf-github-control.name
}
