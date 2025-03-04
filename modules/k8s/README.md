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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud-nat"></a> [cloud-nat](#module\_cloud-nat) | terraform-google-modules/cloud-nat/google | 5.3 |
| <a name="module_databases"></a> [databases](#module\_databases) | terraform-google-modules/sql-db/google//modules/postgresql | 25.2 |
| <a name="module_db_users_password"></a> [db\_users\_password](#module\_db\_users\_password) | GoogleCloudPlatform/secret-manager/google | 0.7 |
| <a name="module_gke_autopilot"></a> [gke\_autopilot](#module\_gke\_autopilot) | terraform-google-modules/kubernetes-engine/google//modules/beta-autopilot-private-cluster | 36.0.0 |
| <a name="module_my-app-workload-identity"></a> [my-app-workload-identity](#module\_my-app-workload-identity) | terraform-google-modules/kubernetes-engine/google//modules/workload-identity | 36.0.0 |
| <a name="module_network_subnets"></a> [network\_subnets](#module\_network\_subnets) | terraform-google-modules/network/google//modules/subnets | 10.0.0 |
| <a name="module_network_vpc"></a> [network\_vpc](#module\_network\_vpc) | terraform-google-modules/network/google//modules/vpc | 10.0.0 |
| <a name="module_psc_connections"></a> [psc\_connections](#module\_psc\_connections) | gitlab.ebi.ac.uk/wap-public/google-service-private-connect-sql/gcp | 0.0.2 |

## Resources

| Name | Type |
|------|------|
| [google_compute_router.main_router](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_project_service.enable_secrets_manager](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_deletion_protection"></a> [cluster\_deletion\_protection](#input\_cluster\_deletion\_protection) | Protect the cluster against deletion | `bool` | `"false"` | no |
| <a name="input_databases"></a> [databases](#input\_databases) | SQL instances to be created in the project. Each item is a SQL instance | <pre>map(object({<br/>    private_address                 = string<br/>    maintenance_window_update_track = optional(string, "stable")<br/>    maintenance_window_hour         = optional(number, 12)<br/>    maintenance_window_day          = optional(number, 6)<br/>    deletion_protection_enabled     = optional(bool, true)<br/>    availability_type               = optional(string, "ZONAL")<br/>    additional_users = optional(list(object({<br/>      name            = string<br/>      password        = string<br/>      random_password = bool<br/>    })), [])<br/>    ipv4_enabled     = optional(bool, false)<br/>    psc_enabled      = optional(bool, true)<br/>    database_version = optional(string, "POSTGRES_15")<br/>    primary_az       = optional(string, "europe-west2-a")<br/>    instance_type    = optional(string, "db-f1-micro")<br/>    name             = optional(string, "")<br/>    secondary_az     = optional(string, "europe-west2-b")<br/>    database_charset = optional(string, "UTF8")<br/>    additional_databases = optional(list(object({<br/>      name      = string<br/>      charset   = string<br/>      collation = string<br/>    })), [])<br/>    database_collation = optional(string, "en_US.UTF8")<br/>    database_flags     = optional(any, [{ name = "autovacuum", value = "off" }])<br/>    insights_config = optional(any, {<br/>      query_insights_enabled  = true,<br/>      query_plans_per_minute  = 5,<br/>      query_string_length     = 1024,<br/>      record_application_tags = false,<br/>      record_client_address   = false,<br/>    })<br/>    backup_configuration = optional(any, {<br/>      enabled                        = true<br/>      start_time                     = "00:00"<br/>      location                       = null<br/>      point_in_time_recovery_enabled = false<br/>      transaction_log_retention_days = null<br/>      retained_backups               = 1<br/>      retention_unit                 = "COUNT"<br/>    })<br/>  }))</pre> | n/a | yes |
| <a name="input_default_azs"></a> [default\_azs](#input\_default\_azs) | The default zones for the GKE clusters | `list(string)` | <pre>[<br/>  "europe-west2-a",<br/>  "europe-west2-b",<br/>  "europe-west2-c"<br/>]</pre> | no |
| <a name="input_enable_private_nodes"></a> [enable\_private\_nodes](#input\_enable\_private\_nodes) | n/a | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment environment | `string` | n/a | yes |
| <a name="input_grant_registry_access"></a> [grant\_registry\_access](#input\_grant\_registry\_access) | n/a | `bool` | `false` | no |
| <a name="input_horizontal_pod_autoscaling"></a> [horizontal\_pod\_autoscaling](#input\_horizontal\_pod\_autoscaling) | n/a | `bool` | `true` | no |
| <a name="input_master_ipv4_cidr_block"></a> [master\_ipv4\_cidr\_block](#input\_master\_ipv4\_cidr\_block) | n/a | `string` | `"10.0.0.0/28"` | no |
| <a name="input_oidc_service_accounts"></a> [oidc\_service\_accounts](#input\_oidc\_service\_accounts) | service account in the GKE cluster to use GCP services | <pre>map(object({<br/>    roles               = list(string)<br/>    namespace           = string<br/>    use_existing_k8s_sa = optional(bool, true)<br/>    annotate_k8s_sa     = optional(bool, false)<br/>  }))</pre> | `{}` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project to deploy the infrastructure | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"europe-west2"` | no |
| <a name="input_secondary_ranges"></a> [secondary\_ranges](#input\_secondary\_ranges) | GKE secondary ranges | <pre>map(list(object({<br/>    range_name    = string<br/>    ip_cidr_range = string<br/>  })))</pre> | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnets to create on the VPC | <pre>list(object({<br/>    subnet_name           = string<br/>    subnet_ip             = string<br/>    subnet_region         = string<br/>    subnet_private_access = optional(bool, true)<br/>    description           = string<br/>  }))</pre> | n/a | yes |
| <a name="input_use_sql_proxy"></a> [use\_sql\_proxy](#input\_use\_sql\_proxy) | Use cloud proxy to connect to the Cloud SQL database | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network_id"></a> [network\_id](#output\_network\_id) | The ID of the created VPC network. |
