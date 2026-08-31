data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "platform" {
  name               = "${var.project_name}-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = { Name = "${var.project_name}-ec2-role" }
}

data "aws_iam_policy_document" "ecr_access" {
  statement {
    sid       = "GetEcrAuthorizationToken"
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    sid    = "PushAndPullApplicationImage"
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]
    resources = [aws_ecr_repository.application.arn]
  }
}

resource "aws_iam_role_policy" "ecr_access" {
  name   = "${var.project_name}-ecr-access"
  role   = aws_iam_role.platform.id
  policy = data.aws_iam_policy_document.ecr_access.json
}

resource "aws_iam_instance_profile" "platform" {
  name = "${var.project_name}-ec2-profile"
  role = aws_iam_role.platform.name
}
