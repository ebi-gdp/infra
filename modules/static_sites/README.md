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
| [google_compute_global_forwarding_rule.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_forwarding_rule) | resource |
| [google_compute_global_forwarding_rule.http_redirect_rule](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_forwarding_rule) | resource |
| [google_compute_managed_ssl_certificate.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_managed_ssl_certificate) | resource |
| [google_compute_ssl_policy.modern_ssl](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_ssl_policy) | resource |
| [google_compute_target_http_proxy.http_redirect](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_target_http_proxy) | resource |
| [google_compute_target_https_proxy.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_target_https_proxy) | resource |
| [google_compute_url_map.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map) | resource |
| [google_compute_url_map.http_redirect](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map) | resource |
| [google_storage_bucket.public_buckets](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_binding.public_access](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_binding) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"europe-west2"` | no |
| <a name="input_static_buckets"></a> [static\_buckets](#input\_static\_buckets) | Map subdomain to bucket prefixes (static sites) | `map(string)` | <pre>{<br/>  "docs.geneticscores.org": "geneticscores-org-docs-backend",<br/>  "geneticscores.org": "geneticscores-org-backend",<br/>  "methods.geneticscores.org": "geneticscores-org-methods-backend"<br/>}</pre> | no |
| <a name="input_static_ip"></a> [static\_ip](#input\_static\_ip) | Name of static ip used for kubernetes ingress | <pre>object({<br/>    address : string,<br/>    address_type : string,<br/>    id : string,<br/>    name : string,<br/>    network : string,<br/>    network_tier : string,<br/>    prefix_length : number,<br/>    project : string,<br/>    purpose : string,<br/>    self_link : string,<br/>    status : string,<br/>    subnetwork : string,<br/>    users : string,<br/>  })</pre> | n/a | yes |

## Outputs

No outputs.
