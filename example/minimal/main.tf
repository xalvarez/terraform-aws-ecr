provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    region  = "eu-central-1"
    encrypt = true
  }
}

module "ecr" {
  source                   = "../.."
  name                     = "xalvarez/example"
  tag_prefix_list          = ["release"]
  scan_on_push             = true
  only_pull_accounts       = var.account_ids
  max_untagged_image_count = 5
  max_tagged_image_count   = 10
}
