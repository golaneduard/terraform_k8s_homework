resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "${var.env}-TestTable"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "ID"
  range_key      = "userId"

  attribute {
    name = "ID"
    type = "S"
  }

  attribute {
    name = "userId"
    type = "S"
  }

  attribute {
    name = "TopScore"
    type = "N"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = {
    Name        = "${var.env}-TestTable"
    Environment = "${var.env}"
  }
}