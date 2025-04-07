dependency "vpc" {
  config_path = find_in_parent_folders("networking")
  mock_outputs = {
    vpc_id = "mock-vpc"
    private_subnets_id = ["private-subnet-1", "private-subnet-2", "private-subnet-3"]
    public_subnets_id  = ["public-subnet-1", "public-subnet-2", "public-subnet-3"]
    ssl_certificate_arn = "arn:aws:sns:us-east-1:123456789012:mock"
    aws_security_group_allow_internal_id = "mock-sg-allow-internal-id"
    aws_security_group_allow_codefactory_id = "mock-sg-allow-codefactory-id"
    aws_route53_zone_internal_id = "mock-r53-zone-internal-id"
    aws_route53_zone_internal_name = "mock-r53-zone-internal-name"
    vpc_cidr_block = "1.1.0.0/16"
    aws_security_group_lb_access_id = "mock-sg-allow-lb-id"
    aws_security_group_allow_jenkins_id = "mock-sg-allow-jenkins-id"
    aws_security_group_allow_vpn = "mock-sg-allow-vpn"
    aws_security_group_allow_egress_id = "mock-sg-allow-egress"
  }

  mock_outputs_allowed_terraform_commands = ["plan","destroy"]
}

dependency "key_pair" {
  config_path = find_in_parent_folders("key-pair")
  mock_outputs = {
    ssh_key_name = "mock-ssh-key-name"
  }

  mock_outputs_allowed_terraform_commands = ["plan","destroy"]
}

dependency "secrets_manager" {
  config_path = find_in_parent_folders("secrets-manager")
  mock_outputs = {
    aws_secretsmanager_secret_cb_string               = "{\"couchbase_user_name\": \"mock-username\",\"couchbase_user_password\": \"mock-password\"}"
    aws_secretsmanager_secret_pgsql_secret_string   = "{\"username\": \"mock-username\",\"password\": \"mock-password\"}"
    aws_secretsmanager_secret_dd_string                = "{\"api_key\": \"mock-api-key\",\"app_key\": \"mock-app-key\"}"
    aws_secretsmanager_secret_cb_bckp_string           = "{\"id\": \"mock-id\",\"key\": \"mock-key\"}"
    aws_secretsmanager_secret_ec2_string               = "{\"scadmin_stg_perf_public_key_file\": \"mock-public-key-file\",\"scadmin_stg_perf_private_key_file\": \"mock-private-key-file\"}"
  }

  mock_outputs_allowed_terraform_commands = ["plan","destroy"]
}
