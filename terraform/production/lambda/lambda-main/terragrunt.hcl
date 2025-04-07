exclude {
  if = false                       # Explicitly exclude.
  actions = ["all_except_output"] # Allow `output.tf` actions nonetheless.
  exclude_dependencies = false    # Dependencies remain active.
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "root_provider" {
  path = find_in_parent_folders("root_provider.hcl")
}

include "env" {
  path = find_in_parent_folders("env.hcl")
}

dependency "lambda_iam" {
  config_path = find_in_parent_folders("lambda-iam")

  mock_outputs = {
    aws_iam_role_lambda_arn = "mock-aws_iam_role_lambda_arn"
  }

  mock_outputs_allowed_terraform_commands = ["destroy","plan"]
}

dependency "sqs" {
  config_path = find_in_parent_folders("sqs")

  mock_outputs = {
    aws_sqs_queue_arn = "mock-aws_sqs_queue_arn"
  }

  mock_outputs_allowed_terraform_commands = ["destroy","plan"]
}

dependency "cloudwatch" {
  config_path = find_in_parent_folders("cloudwatch")
}

dependency "dynamodb" {
  config_path = find_in_parent_folders("dynamodb")
}

inputs = {
  aws_iam_role_lambda_arn = dependency.lambda_iam.outputs.aws_iam_role_lambda_arn
  aws_sqs_queue_arn       = dependency.sqs.outputs.aws_sqs_queue_arn
}
