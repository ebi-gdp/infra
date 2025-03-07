## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0, < 2.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 6 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 6 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | ~> 2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bucket"></a> [bucket](#module\_bucket) | terraform-google-modules/cloud-storage/google//modules/simple_bucket | ~> 9.1 |
| <a name="module_my-app-workload-identity"></a> [my-app-workload-identity](#module\_my-app-workload-identity) | terraform-google-modules/kubernetes-engine/google//modules/workload-identity | 36.0.0 |

## Resources

| Name | Type |
|------|------|
| [google_project_service.services](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [kubernetes_namespace.default](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autopilot_ca_certificate"></a> [autopilot\_ca\_certificate](#input\_autopilot\_ca\_certificate) | n/a | `string` | n/a | yes |
| <a name="input_autopilot_endpoint"></a> [autopilot\_endpoint](#input\_autopilot\_endpoint) | n/a | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment environment | `string` | n/a | yes |
| <a name="input_oidc_service_accounts"></a> [oidc\_service\_accounts](#input\_oidc\_service\_accounts) | service account in the GKE cluster to use GCP services | <pre>map(object({<br/>    roles               = list(string)<br/>    namespace           = string<br/>    use_existing_k8s_sa = optional(bool, false)<br/>  }))</pre> | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project to deploy the infrastructure | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"europe-west2"` | no |

## Outputs

No outputs.
