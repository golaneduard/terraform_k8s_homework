############################
### IAM Policy Documents ###
############################
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "lambda_logging_tracing" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords",
      "xray:GetSamplingRules",
      "xray:GetSamplingTargets",
      "xray:GetSamplingStatisticSummaries"
    ]

    resources = ["*"]
  }
}

####################
### IAM Policies ###
####################
resource "aws_iam_policy" "lambda_logging" {
  name        = "${var.env}-lambda-logging"
  description = "IAM policy for logging from a lambda"
  policy      = data.aws_iam_policy_document.lambda_logging_tracing.json

  tags = merge(var.root_tags, var.env_tags)
}

##############################
### IAM Policy Attachments ###
##############################
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

resource "aws_iam_role_policy_attachment" "insights_policy" {
  role       = aws_iam_role.iam_for_lambda.id
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLambdaInsightsExecutionRolePolicy"
}

#################
### IAM Roles ###
#################
resource "aws_iam_role" "iam_for_lambda" {
  name               = "${var.env}-iam-for-lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = merge(var.root_tags, var.env_tags)
}
