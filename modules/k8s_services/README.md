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
| <a name="module_uptime-check-calculation"></a> [uptime-check-calculation](#module\_uptime-check-calculation) | terraform-google-modules/cloud-operations/google//modules/simple-uptime-check | 0.6.0 |

## Resources

| Name | Type |
|------|------|
| [google_iam_workload_identity_pool.gitlab](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool) | resource |
| [google_iam_workload_identity_pool_provider.gitlab-provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider) | resource |
| [google_monitoring_alert_policy.server_exception_alert](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy) | resource |
| [google_monitoring_notification_channel.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel) | resource |
| [google_project_service.dbservices](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.services](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_secret_manager_secret.secrets](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_iam_binding.gitlab_secret_access](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_iam_binding) | resource |
| [google_secret_manager_secret_version.secrets](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [kubernetes_ingress_v1.app_ingress](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [kubernetes_manifest.managed_cert](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace.default](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alert_contact"></a> [alert\_contact](#input\_alert\_contact) | Alert contact | `string` | `"gdp-dev@ebi.ac.uk"` | no |
| <a name="input_autopilot_ca_certificate"></a> [autopilot\_ca\_certificate](#input\_autopilot\_ca\_certificate) | n/a | `string` | n/a | yes |
| <a name="input_autopilot_endpoint"></a> [autopilot\_endpoint](#input\_autopilot\_endpoint) | n/a | `string` | n/a | yes |
| <a name="input_basic_auth_secret"></a> [basic\_auth\_secret](#input\_basic\_auth\_secret) | Configuration for microservices using basic access authentication | <pre>object({<br/>    BASIC_AUTH_USERNAME = string<br/>    BASIC_AUTH_PASSWORD = string<br/>    SEC_KEY_PASSWORD    = string<br/>  })</pre> | n/a | yes |
| <a name="input_calculation_uptime_targets"></a> [calculation\_uptime\_targets](#input\_calculation\_uptime\_targets) | Public uptime check targets (calculation service) | `map(string)` | <pre>{<br/>  "/bff/actuator/health": "Calculation service: Backend for frontend",<br/>  "/bff/key-handler/actuator/health": "Calculation service: Key handler",<br/>  "/bff/pipeline-manager/actuator/health": "Calculation service: Pipeline manager",<br/>  "/bff/user-manager/actuator/health": "Calculation service: User manager"<br/>}</pre> | no |
| <a name="input_db_secret"></a> [db\_secret](#input\_db\_secret) | Username/password for CloudSQL database | <pre>object({<br/>    DB_USERNAME = string<br/>    DB_PASSWORD = string<br/>  })</pre> | n/a | yes |
| <a name="input_email_secret"></a> [email\_secret](#input\_email\_secret) | Configuration for email notifications | <pre>object({<br/>    INTERVENE_EMAIL_ID       = string<br/>    INTERVENE_EMAIL_PASSWORD = string<br/>  })</pre> | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment environment | `string` | n/a | yes |
| <a name="input_gitlab_project_ids"></a> [gitlab\_project\_ids](#input\_gitlab\_project\_ids) | Project IDs with Gitlab Ci/CD pipelines that need to read from the GCP secret manager | <pre>object(<br/>    {<br/>      backend_for_frontend_gateway = string<br/>      platform                     = string<br/>    }<br/>  )</pre> | <pre>{<br/>  "backend_for_frontend_gateway": "4766",<br/>  "platform": "4654"<br/>}</pre> | no |
| <a name="input_globus_secret"></a> [globus\_secret](#input\_globus\_secret) | Configuration for globus authentication | <pre>object({<br/>    GLOBUS_CLIENT_ID     = string<br/>    GLOBUS_CLIENT_SECRET = string<br/>  })</pre> | n/a | yes |
| <a name="input_oidc_service_accounts"></a> [oidc\_service\_accounts](#input\_oidc\_service\_accounts) | service account in the GKE cluster to use GCP services | <pre>map(object({<br/>    roles                           = list(string)<br/>    namespace                       = string<br/>    use_existing_k8s_sa             = optional(bool, false)<br/>    automount_service_account_token = optional(bool, false)<br/>  }))</pre> | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project to deploy the infrastructure | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"europe-west2"` | no |
| <a name="input_static_ip_name"></a> [static\_ip\_name](#input\_static\_ip\_name) | Name of static ip used for kubernetes ingress | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_notification_channel"></a> [notification\_channel](#output\_notification\_channel) | Created notification channel |
