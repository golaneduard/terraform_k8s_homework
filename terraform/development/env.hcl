locals {
  region_main    = "eu-north"
  region         = "${local.region_main}-1"
  env            = "stg-perf"
  datadog_region = "ap1"
}

inputs = {
  account_id     = "254864430905"
  env            = "${local.env}"
  region         = "${local.region}"
  desired_zones  = ["${local.region_main}-1b","${local.region_main}-1c"]
  datadog_region = "${local.datadog_region}"
  env_tags       = {
    Env = "${local.env}"
  }
}
