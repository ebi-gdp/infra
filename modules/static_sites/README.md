## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0, < 2.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_backend_bucket.public_backends](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_backend_bucket) | resource |
| [google_compute_global_address.static_lb_ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_compute_global_forwarding_rule.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_forwarding_rule) | resource |
| [google_compute_target_http_proxy.static-sites](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_target_http_proxy) | resource |
| [google_compute_url_map.static_site_url_map](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map) | resource |
| [google_storage_bucket.public_buckets](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_binding.public_access](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_binding) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment environment | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project to deploy the infrastructure | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"europe-west2"` | no |
| <a name="input_static_buckets"></a> [static\_buckets](#input\_static\_buckets) | Map subdomain to bucket prefixes (static sites) | `map(string)` | <pre>{<br/>  "docs.geneticscores.org": "geneticscores-org-docs",<br/>  "geneticscores.org": "geneticscores-org",<br/>  "methods.geneticscores.org": "geneticscores-org-methods"<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_load_balancer_id"></a> [load\_balancer\_id](#output\_load\_balancer\_id) | The id of the created load balancer |
