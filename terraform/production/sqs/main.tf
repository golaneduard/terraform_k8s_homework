resource "aws_sqs_queue" "queue_deadletter" {
  name = "${var.env}-terraform-example-deadletter-queue"

  tags = merge(var.root_tags, var.env_tags)
}

resource "aws_sqs_queue" "queue" {
  name                      = "${var.env}-terraform-example-queue"
  max_message_size          = 2048
  message_retention_seconds = 262144

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.queue_deadletter.arn
    maxReceiveCount     = 4
  })

  tags = merge(var.root_tags, var.env_tags)
}
