// set up a kubernetes provider in this module using the outputs of the autopilot module
data "google_client_config" "default" {
}

provider "kubernetes" {
  host                   = "https://${var.autopilot_endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(var.autopilot_ca_certificate)
}

provider "helm" {
  kubernetes = {
    host                   = "https://${var.autopilot_endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(var.autopilot_ca_certificate)
  }
}