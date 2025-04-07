locals {
  region         = "eu-central-1"
  env            = "development"
}

inputs = {
  account_id     = "254864430905"
  env            = "${local.env}"
  region         = "${local.region}"
  env_tags       = {
    Env = "${local.env}"
  }
}
