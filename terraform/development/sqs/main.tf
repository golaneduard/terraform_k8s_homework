resource "aws_sqs_queue" "queue" {
  name                      = "${var.env}-terraform-example-queue"
  max_message_size          = 2048
  message_retention_seconds = 262144

  tags = merge(var.root_tags, var.env_tags)
}
