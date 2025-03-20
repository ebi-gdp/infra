/*
* Binding Kubernetes service accounts to GCP service accounts
*/

module "my-app-workload-identity" {
  for_each                        = var.oidc_service_accounts
  source                          = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  version                         = "36.0.0"
  name                            = each.key
  use_existing_k8s_sa             = each.value.use_existing_k8s_sa
  namespace                       = each.value.namespace
  project_id                      = var.project_id
  roles                           = each.value.roles
  automount_service_account_token = each.value.automount_service_account_token

  depends_on = [kubernetes_namespace.default]
}
