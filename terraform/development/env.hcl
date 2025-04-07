locals {
  env            = "development"
}

inputs = {
  account_id     = "254864430905"
  env            = "${local.env}"
  region         = "eu-central-1"
  env_tags       = {
    Env = "${local.env}"
  }
}
