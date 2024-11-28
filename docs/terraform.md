<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.78.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.78.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_controltower_landing_zone.zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/controltower_landing_zone) | resource |
| [aws_iam_policy.cloudtrail_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.controltower_admin_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.stackset_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.config_aggregator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.controltower_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.stackset](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cloudtrail_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.config_aggregator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.controltower_admin_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.stackset_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_alias.controltower](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.controltower](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key_policy.controltower](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy) | resource |
| [aws_organizations_account.audit](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account) | resource |
| [aws_organizations_account.log_archive](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_logging_bucket_retention_days"></a> [access\_logging\_bucket\_retention\_days](#input\_access\_logging\_bucket\_retention\_days) | The number of days to retain log objects in the centralized access logging bucket. | `number` | `3650` | no |
| <a name="input_account_name_audit"></a> [account\_name\_audit](#input\_account\_name\_audit) | The name of the account to use for audit. | `string` | `"Audit"` | no |
| <a name="input_account_name_log_archiver"></a> [account\_name\_log\_archiver](#input\_account\_name\_log\_archiver) | The name of the account to use for centralized logging. | `string` | `"Log archive"` | no |
| <a name="input_additional_organizational_unit_name"></a> [additional\_organizational\_unit\_name](#input\_additional\_organizational\_unit\_name) | The name of an additional organizational unit to create in AWS Control Tower. | `string` | `"Custom"` | no |
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br/>This is for some rare cases where resources want additional configuration of tags<br/>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br/>in the order they appear in the list. New attributes are appended to the<br/>end of the list. The elements of the list are joined by the `delimiter`<br/>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br/>See description of individual variables for details.<br/>Leave string and numeric variables as `null` to use default value.<br/>Individual variable settings (non-null) override settings in context object,<br/>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br/>  "additional_tag_map": {},<br/>  "attributes": [],<br/>  "delimiter": null,<br/>  "descriptor_formats": {},<br/>  "enabled": true,<br/>  "environment": null,<br/>  "id_length_limit": null,<br/>  "label_key_case": null,<br/>  "label_order": [],<br/>  "label_value_case": null,<br/>  "labels_as_tags": [<br/>    "unset"<br/>  ],<br/>  "name": null,<br/>  "namespace": null,<br/>  "regex_replace_chars": null,<br/>  "stage": null,<br/>  "tags": {},<br/>  "tenant": null<br/>}</pre> | no |
| <a name="input_create_operation_timeout"></a> [create\_operation\_timeout](#input\_create\_operation\_timeout) | The amount of time allowed for the create operation to take before being considered to have failed. | `string` | `"60m"` | no |
| <a name="input_delete_operation_timeout"></a> [delete\_operation\_timeout](#input\_delete\_operation\_timeout) | The amount of time allowed for the delete operation to take before being considered to have failed. | `string` | `"60m"` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br/>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br/>Map of maps. Keys are names of descriptors. Values are maps of the form<br/>`{<br/>   format = string<br/>   labels = list(string)<br/>}`<br/>(Type is `any` so the map values can later be enhanced to provide additional options.)<br/>`format` is a Terraform format string to be passed to the `format()` function.<br/>`labels` is a list of labels, in order, to pass to `format()` function.<br/>Label values will be normalized before being passed to `format()` so they will be<br/>identical to how they appear in `id`.<br/>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_email_address_account_audit"></a> [email\_address\_account\_audit](#input\_email\_address\_account\_audit) | The email address to use for the account to use for audit. | `string` | n/a | yes |
| <a name="input_email_address_account_log_archiver"></a> [email\_address\_account\_log\_archiver](#input\_email\_address\_account\_log\_archiver) | The email address to use for the account to use for centralized logging. | `string` | n/a | yes |
| <a name="input_enable_access_management"></a> [enable\_access\_management](#input\_enable\_access\_management) | Whether to enable access management in AWS Control Tower. | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_existing_key_arn"></a> [existing\_key\_arn](#input\_existing\_key\_arn) | The ARN of an existing KMS key to use for AWS Control Tower. | `string` | `""` | no |
| <a name="input_foundational_organizational_unit_name"></a> [foundational\_organizational\_unit\_name](#input\_foundational\_organizational\_unit\_name) | The name of the organizational unit to create in AWS Control Tower which houses the Audit and Log accounts | `string` | `"Core"` | no |
| <a name="input_governed_regions"></a> [governed\_regions](#input\_governed\_regions) | A list of AWS regions to govern with AWS Control Tower. The region where you deploy the landing zone MUST always be included in this list. | `list(string)` | <pre>[<br/>  "us-east-1",<br/>  "us-east-2"<br/>]</pre> | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br/>Set to `0` for unlimited length.<br/>Set to `null` for keep the existing setting, which defaults to `0`.<br/>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_kms_key_admins"></a> [kms\_key\_admins](#input\_kms\_key\_admins) | A list of IAM users or roles that should be granted administrative access to the KMS key. | `list(string)` | `[]` | no |
| <a name="input_kms_key_alias_name"></a> [kms\_key\_alias\_name](#input\_kms\_key\_alias\_name) | The alias to use for the KMS key used by AWS Control Tower. | `string` | `"control_tower_key"` | no |
| <a name="input_kms_key_users"></a> [kms\_key\_users](#input\_kms\_key\_users) | A list of IAM users or roles that should be granted user access to the KMS key. | `list(string)` | `[]` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br/>Does not affect keys of tags passed in via the `tags` input.<br/>Possible values: `lower`, `title`, `upper`.<br/>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br/>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br/>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br/>set as tag values, and output by this module individually.<br/>Does not affect values of tags passed in via the `tags` input.<br/>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br/>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br/>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br/>Default is to include all labels.<br/>Tags with empty values will not be included in the `tags` output.<br/>Set to `[]` to suppress all generated tags.<br/>**Notes:**<br/>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br/>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br/>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br/>  "default"<br/>]</pre> | no |
| <a name="input_landing_zone_version"></a> [landing\_zone\_version](#input\_landing\_zone\_version) | The version of the AWS Control Tower landing zone to deploy. | `string` | `"3.3"` | no |
| <a name="input_logging_bucket_retention_days"></a> [logging\_bucket\_retention\_days](#input\_logging\_bucket\_retention\_days) | The number of days to retain log objects in the centralized logging bucket. | `number` | `365` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br/>This is the only ID element not also included as a `tag`.<br/>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br/>Characters matching the regex will be removed from the ID elements.<br/>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br/>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
| <a name="input_update_operation_timeout"></a> [update\_operation\_timeout](#input\_update\_operation\_timeout) | The amount of time allowed for the update operation to take before being considered to have failed. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/servicecatalog_provisioned_product#timeouts | `string` | `"60m"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_audit_account_id"></a> [audit\_account\_id](#output\_audit\_account\_id) | The AWS account ID of the Control Tower audit account |
| <a name="output_landing_zone_arn"></a> [landing\_zone\_arn](#output\_landing\_zone\_arn) | The ARN of the Control Tower landing zone |
| <a name="output_log_archive_account_id"></a> [log\_archive\_account\_id](#output\_log\_archive\_account\_id) | The AWS account ID of the Control Tower log archive account |
| <a name="output_manifest"></a> [manifest](#output\_manifest) | The manifest configuration used to create the Control Tower landing zone |
<!-- markdownlint-restore -->
