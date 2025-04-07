locals {
  env = "production"
}

inputs = {
  lambda_function_name = "${local.env}-lambda-function-name"
  account_id           = "699347609631"
  env                  = "${local.env}"
  region               = "eu-north-1"
  env_tags             = {
    Env = "${local.env}"
  }
}
