## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0, < 2.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 6.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_uptime-check-static-sites"></a> [uptime-check-static-sites](#module\_uptime-check-static-sites) | terraform-google-modules/cloud-operations/google//modules/simple-uptime-check | 0.6.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_notification_channel"></a> [notification\_channel](#input\_notification\_channel) | Notification channel ID | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project to deploy the infrastructure | `string` | n/a | yes |
| <a name="input_uptime_targets"></a> [uptime\_targets](#input\_uptime\_targets) | Public uptime check targets (static sites) | `map(string)` | <pre>{<br/>  "calculate.geneticscores.org": "GeneticScores.org calculation service",<br/>  "docs.geneticscores.org": "GeneticScores.org documentation",<br/>  "geneticscores.org": "GeneticScores.org landing page",<br/>  "intervenegeneticscores.org": "intervenegeneticscores.org permanent redirect",<br/>  "methods.geneticscores.org": "GeneticScores.org methods comparison",<br/>  "methodscomparison.intervenegeneticscores.org": "methodscomparison.intervenegeneticscores.org permanent redirect"<br/>}</pre> | no |

## Outputs

No outputs.
