locals {
  env_hcl  = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  root_hcl = read_terragrunt_config(find_in_parent_folders("root.hcl"))
}

# Configure the AWS provider
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "${local.root_hcl.locals.aws_provider_version}"
    }
  }
}

provider "aws" {
  region = "${local.env_hcl.locals.region}"
}
EOF
}
