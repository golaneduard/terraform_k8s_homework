resource "aws_lambda_function" "test_lambda" {
  filename      = "lambda_function_payload.zip"
  function_name = "${var.env}-lambda-function-name"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"

  runtime = "python3.9"

  # Enable tracing with X-Ray
  tracing_config {
    mode = "Active"
  }

  layers = [
    "arn:aws:lambda:${var.region}:${var.account_id}:layer:LambdaInsightsExtension:14"
  ]

  environment {
    variables = {
      foo = "bar"
    }
  }

}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  event_source_arn = "${var.terraform_queue_arn}"
  enabled          = true
  function_name    = "${aws_lambda_function.test_lambda.arn}"
  batch_size       = 1
}
