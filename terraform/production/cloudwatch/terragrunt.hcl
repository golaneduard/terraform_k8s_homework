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
