terraform {
  required_version = ">= 1.0.0, < 2.0.0"
}

data "google_client_config" "default" {
}

data "google_project" "project" {
}

provider "kubernetes" {
  host                   = "https://${var.autopilot_endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(var.autopilot_ca_certificate)
}

// set up the default namespaces

resource "kubernetes_namespace" "default" {
  for_each = local.namespaces

  metadata {
    name = each.key
  }

}
