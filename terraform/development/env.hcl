locals {
  env = "development"
}

inputs = {
  lambda_function_name = "${local.env}-lambda-function-name"
  account_id           = "254864430905"
  env                  = "${local.env}"
  region               = "eu-central-1"
  env_tags             = {
    Env = "${local.env}"
  }
}
