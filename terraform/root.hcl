remote_state {
  backend = "s3"
  generate = {
    path      = "state.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket = "${split("/", path_relative_to_include())[0]}-tfstate"

    key            = "${path_relative_to_include()}/tfstate"
    region         = "eu-central-1"
    encrypt        = true
    # dynamodb_table = "my-lock-table"
  }
}

locals {
  aws_provider_version        = "5.84"
}

inputs = {
  vpn_skycity_ip = [
    "172.139.43.68/32",
    "3.75.16.221/32"
  ]
  sandbox_vpc_id = "vpc-02fbe5c46643427be"
  root_tags = {
    terraform-managed = true
  }
}

terraform_version_constraint = "= 1.10.5"
terragrunt_version_constraint = "= 0.72.4"
