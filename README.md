# terraform-aws-ecr

**Note: The original repository does not seem to be maintained anymore, and I haven't been able to reach
its owner since over a year and a half. Therefore, I've decided to maintain this fork to my taste.**

## Description

Terraform module which creates ECR resources on AWS.

Provision [ECR Repository](https://docs.aws.amazon.com/AmazonECR/latest/userguide/Repositories.html),
[Repository Policy](https://docs.aws.amazon.com/AmazonECR/latest/userguide/RepositoryPolicies.html) and
[Lifecycle Policy](https://docs.aws.amazon.com/AmazonECR/latest/userguide/LifecyclePolicies.html).

This module provides recommended settings:

- Enable cross account access
- Automation of cleaning up unused images

## Usage

### Minimal

```hcl
module "ecr" {
  source          = "git@github.com:xalvarez/terraform-aws-ecr.git?ref=3.0.0"
  name            = "minimal"
  tag_prefix_list = ["release"]
}
```

### Complete

```hcl
module "ecr" {
  source               = "git@github.com:xalvarez/terraform-aws-ecr.git?ref=3.0.0"
  name                 = "complete"
  tag_prefix_list      = ["release"]
  scan_on_push         = true
  image_tag_mutability = "IMMUTABLE"

  only_pull_accounts       = ["123456789012"]
  push_and_pull_accounts   = ["111111111111"]
  max_untagged_image_count = 5
  max_tagged_image_count   = 50
}
```

## Examples

- [Minimal](https://github.com/xalvarez/terraform-aws-ecr/tree/master/examples/minimal)
- [Complete](https://github.com/xalvarez/terraform-aws-ecr/tree/master/examples/complete)

## Requirements

| Name      | Version |
| --------- | ------- |
| terraform | >= 1.0  |

## Providers

| Name | Version |
| ---- | ------- |
| aws  | n/a     |

## Inputs

| Name                     | Description                                                                  | Type           | Default       | Required |
| ------------------------ | ---------------------------------------------------------------------------- | -------------- | ------------- | :------: |
| name                     | Name of the repository.                                                      | `string`       | n/a           |   yes    |
| tag_prefix_list          | List of image tag prefixes on which to take action with lifecycle policy.    | `list(string)` | n/a           |   yes    |
| image_tag_mutability     | Whether images are allowed to overwrite existing tags.                       | `string`       | `"IMMUTABLE"` |    no    |
| max_tagged_image_count   | The maximum number of tagged images that you want to retain in repository.   | `number`       | `30`          |    no    |
| max_untagged_image_count | The maximum number of untagged images that you want to retain in repository. | `number`       | `1`           |    no    |
| only_pull_accounts       | AWS accounts which pull only.                                                | `list(string)` | `[]`          |    no    |
| push_and_pull_accounts   | AWS accounts which push and pull.                                            | `list(string)` | `[]`          |    no    |
| scan_on_push             | Whether images should automatically be scanned on push or not.               | `bool`         | `true`        |    no    |

## Outputs

| Name                       | Description                                                                                        |
| -------------------------- | -------------------------------------------------------------------------------------------------- |
| ecr_repository_arn         | Full ARN of the repository.                                                                        |
| ecr_repository_name        | The name of the repository.                                                                        |
| ecr_repository_registry_id | The registry ID where the repository was created.                                                  |
| ecr_repository_url         | The URL of the repository (in the form aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName) |

## License

Apache 2 Licensed. See LICENSE for full details.
