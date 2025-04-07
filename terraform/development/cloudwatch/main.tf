resource "aws_cloudwatch_log_group" "example" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 14

  tags = merge(var.root_tags, var.env_tags)
}