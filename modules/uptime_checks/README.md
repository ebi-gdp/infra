## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0, < 2.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.23.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_uptime-check-calculation"></a> [uptime-check-calculation](#module\_uptime-check-calculation) | terraform-google-modules/cloud-operations/google//modules/simple-uptime-check | 0.6.0 |
| <a name="module_uptime-check-static-sites"></a> [uptime-check-static-sites](#module\_uptime-check-static-sites) | terraform-google-modules/cloud-operations/google//modules/simple-uptime-check | 0.6.0 |

## Resources

| Name | Type |
|------|------|
| [google_monitoring_notification_channel.notification_channel](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alert_contacts"></a> [alert\_contacts](#input\_alert\_contacts) | Alert contacts (format: email = description) | `map(string)` | n/a | yes |
| <a name="input_calculation_uptime_targets"></a> [calculation\_uptime\_targets](#input\_calculation\_uptime\_targets) | Public uptime check targets (calculation service) | `map(string)` | <pre>{<br/>  "/bff/actuator/health": "Calculation service: Backend for frontend",<br/>  "/bff/key-handler/actuator/health": "Calculation service: Key handler",<br/>  "/bff/pipeline-manager/actuator/health": "Calculation service: Pipeline manager",<br/>  "/bff/user-manager/actuator/health": "Calculation service: User manager"<br/>}</pre> | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project to deploy the infrastructure | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"europe-west2"` | no |
| <a name="input_uptime_targets"></a> [uptime\_targets](#input\_uptime\_targets) | Public uptime check targets (static sites) | `map(string)` | <pre>{<br/>  "calculate.geneticscores.org": "GeneticScores.org calculation service",<br/>  "docs.geneticscores.org": "GeneticScores.org documentation",<br/>  "geneticscores.org": "GeneticScores.org landing page",<br/>  "intervenegeneticscores.org": "intervenegeneticscores.org permanent redirect",<br/>  "methods.geneticscores.org": "GeneticScores.org methods comparison",<br/>  "methodscomparison.intervenegeneticscores.org": "methodscomparison.intervenegeneticscores.org permanent redirect"<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_uptime_check_ids"></a> [uptime\_check\_ids](#output\_uptime\_check\_ids) | The IDs of all created uptime checks |
