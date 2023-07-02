## Data Sources

data "aws_iam_policy_document" "ih-tf-aws-control-289256138624-admin-assume" {
  statement {
    sid     = "000"
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::990466748045:user/aleks",
        aws_iam_role.ih-tf-aws-control-289256138624-github.arn
      ]
    }
  }
  statement {
    sid     = "010"
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
        "repo:infrahouse/aws-control-289256138624:*"
      ]
    }
  }
}

data "aws_iam_policy_document" "ih-tf-aws-control-289256138624-github-assume" {
  statement {
    sid     = "010"
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
        "repo:infrahouse/aws-control-289256138624:*"
      ]
    }
  }
}

data "aws_iam_policy_document" "ih-tf-aws-control-289256138624-github-permissions" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    resources = ["*"]
  }
}

## EOF Data Sources


# IAM role

resource "aws_iam_role" "ih-tf-aws-control-289256138624-admin" {
  provider           = aws.aws-289256138624-uw1
  name               = "ih-tf-aws-control-289256138624-admin"
  description        = "Role to manage account 289256138624"
  assume_role_policy = data.aws_iam_policy_document.ih-tf-aws-control-289256138624-admin-assume.json
}

resource "aws_iam_role_policy_attachment" "ih-tf-aws-control-289256138624-admin" {
  provider   = aws.aws-289256138624-uw1
  policy_arn = data.aws_iam_policy.administrator-access.arn
  role       = aws_iam_role.ih-tf-aws-control-289256138624-admin.name
}

resource "aws_iam_role" "ih-tf-aws-control-289256138624-github" {
  provider           = aws.aws-289256138624-uw1
  name               = "ih-tf-aws-control-289256138624-github"
  description        = "Role for a GitHub Actions runner in repo aws-control-289256138624"
  assume_role_policy = data.aws_iam_policy_document.ih-tf-aws-control-289256138624-github-assume.json
  inline_policy {
    name   = "ih-tf-aws-control-289256138624-github-permissions"
    policy = data.aws_iam_policy_document.ih-tf-aws-control-289256138624-github-permissions.json
  }
}
