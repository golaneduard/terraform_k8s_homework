resource "aws_sqs_queue" "terraform_queue_deadletter" {
  name = "${var.env}-terraform-example-deadletter-queue"
}

resource "aws_sqs_queue" "terraform_queue" {
  name = "${var.env}-terraform-example-queue"
  max_message_size          = 2048
  message_retention_seconds = 262144

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.terraform_queue_deadletter.arn
    maxReceiveCount     = 4
  })
}
