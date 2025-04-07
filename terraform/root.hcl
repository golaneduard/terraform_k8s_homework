locals {
  aws_provider_version  = "5.84"
  env_hcl               = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

remote_state {
  backend = "s3"
  generate = {
    path      = "state.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket = "${split("/", path_relative_to_include())[0]}-tfstate"

    key            = "${path_relative_to_include()}/tfstate"
    region         = "${local.env_hcl.locals.region}"
    encrypt        = true
  }
}

inputs = {
  root_tags = {
    terraform-managed = true
  }
}

terraform_version_constraint = "= 1.10.5"
terragrunt_version_constraint = "= 0.72.4"
