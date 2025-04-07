resource "aws_lambda_function" "test_lambda" {
  filename       = "lambda_function_payload.zip"
  function_name = "${var.lambda_function_name}"
  role          = var.aws_iam_role_lambda_arn
  handler       = "lambda_function.lambda_handler"

  runtime = "python3.9"

  # Enable tracing with X-Ray
  tracing_config {
    mode = "Active"
  }

  layers = [
    "arn:aws:lambda:${var.region}:${var.account_id}:layer:LambdaInsightsExtension:14"
  ]

  tags = merge(var.root_tags, var.env_tags)
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  event_source_arn = "${var.aws_sqs_queue_arn}"
  enabled          = true
  function_name    = "${aws_lambda_function.test_lambda.arn}"
  batch_size       = 1

  tags = merge({ Name = "sqs" }, var.root_tags, var.env_tags)
}
