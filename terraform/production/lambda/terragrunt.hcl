exclude {
  if = false                       # Explicitly exclude.
  actions = ["all_except_output"] # Allow `output.tf` actions nonetheless.
  exclude_dependencies = false    # Dependencies remain active.
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "root_provider" {
  path = find_in_parent_folders("root_provider.hcl")
}

include "env" {
  path = find_in_parent_folders("env.hcl")
}

include "root_deps" {
  path = find_in_parent_folders("root_deps.hcl")
}

locals {
  env_hcl = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

inputs = merge(
  local.env_hcl.inputs,
  {
    desired_private_subnets_id           = ["${run_cmd("../desired_subnet_zone.sh","${local.env_hcl.locals.region_main}-1b","${local.env_hcl.locals.env}")}","${run_cmd("../desired_subnet_zone.sh","${local.env_hcl.locals.region_main}-1c","${local.env_hcl.locals.env}")}"]
    aws_security_group_allow_internal_id = dependency.vpc.outputs.aws_security_group_allow_internal_id
    aws_route53_zone_internal_id         = dependency.vpc.outputs.aws_route53_zone_internal_id
    aws_route53_zone_internal_name       = dependency.vpc.outputs.aws_route53_zone_internal_name
    aws_secretsmanager_secret_pgsql_secret_string  = dependency.secrets_manager.outputs.aws_secretsmanager_secret_pgsql_secret_string
  }
)