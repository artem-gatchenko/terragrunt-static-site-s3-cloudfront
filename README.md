![terraform](terraform-logo.png)

# Terragrunt(Terraform) - Static site on S3 with CloudFront
Terragrunt template for create S3 Bucket for static hosting with CloudFront for different enviroments
## This template will create next:

`S3 Bucket` for static site
`CloudFront` for distribution
`DNS Record` on Route 53 for static site
`Certificate` for DNS name
`IAM User` with full access to S3 bucket and access make CreateInvalidation in CloudFront



## Requirements
Terraform version >= *0.12.9*
AWS provider version >= *2.29*

## Getting started
### First change this block on `terragrunt.hcl` file

```
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

```

### And fill in the variable file `common.tfvars`



## Usage
### Environment initialization
Run the *init* command.
```bash
# The first command only for initializing (only if didn't start before)
terragrunt init

```
### Start/change an environment
Run the *plan* or *apply* command.
```bash
# to show changes list for all environments (from root repository)
terragrunt plan-all

# to show changes list for environment (from specific enviroment directory)
terragrunt plan

# to apply the changes for all environments (from root repository)
terragrunt apply-all

# to apply the changes for environment (from specific enviroment directory)
terragrunt plan
```

### Stopping(destroying) an environment
Run the *destroy* command.

**Warning!!!** the command will not just stop but completely remove the infrastructure used for this environment :

```bash
# Run the destroy command for all environments (from root repository)
terragrunt destroy-all

# Run the destroy command for environment (from specific enviroment directory)
terragrunt destroy
```

## How update S3 content

```bash
# upload new data to S3
# region - if missmatch with default region
aws s3 sync my-new-site/ s3://S3_BUCKET_NAME --region AWS_REGION --delete

# make invalidation cache for CloudFront
aws cloudfront create-invalidation --distribution-id=DISTRIBUTION_ID --paths '/index.html'

```
