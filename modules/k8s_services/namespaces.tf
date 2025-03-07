// set up the default namespaces

resource "kubernetes_namespace" "default" {
  for_each = local.namespaces

  metadata {
    name = each.key
  }
}