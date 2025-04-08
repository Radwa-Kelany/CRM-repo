resource "aws_iam_user" "terraform_user_1" {
  name = "t_user_1"
  path = "/system/"

  tags = {
    tag-key = "t_user_1"
  }
}

resource "aws_iam_access_key" "t_user_access_key" {
  user = aws_iam_user.terraform_user_1.name
}

data "aws_iam_policy_document" "t_user_1_doc" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:Describe*"]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy" "t_user_1_policy" {
  name   = "ec2-policy"
  user   = aws_iam_user.terraform_user_1.name
  policy = data.aws_iam_policy_document.t_user_1_doc.json
}