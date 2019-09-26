terraform {
  extra_arguments "custom_vars" {
    commands = get_terraform_commands_that_need_vars()
    arguments = [
      "-var-file=${get_terragrunt_dir()}/common.tfvars",
    ]
  }
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "MY_BUCKET_NAME_FOR_TF_STATES"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "REGION_FOR_S3_BUCKET"
    encrypt        = true
    dynamodb_table = "my-lock-table"
  }
}