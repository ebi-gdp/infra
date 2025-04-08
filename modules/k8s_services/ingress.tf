resource "kubernetes_manifest" "managed_cert" {
  manifest = {
    apiVersion = "networking.gke.io/v1"
    kind       = "ManagedCertificate"
    metadata = {
      name      = "managed-cert"
      namespace = local.default_namespace
    }
    spec = {
      domains = [local.host]
    }
  }
}

resource "google_compute_ssl_policy" "default" {
  name            = "gke-ingress-ssl-policy"
  profile         = "MODERN"
  min_tls_version = "TLS_1_2"
}

resource "kubernetes_manifest" "frontend_config" {
  manifest = {
    apiVersion = "networking.gke.io/v1beta1"
    kind       = "FrontendConfig"
    metadata = {
      name      = "my-frontend-config"
      namespace = local.default_namespace
    }
    spec = {
      sslPolicy = google_compute_ssl_policy.default.name
    }
  }
}

resource "kubernetes_ingress_v1" "app_ingress" {
  metadata {
    name      = "app-ingress-front-back-end-config"
    namespace = local.default_namespace

    annotations = {
      "kubernetes.io/ingress.global-static-ip-name"    = var.static_ip_name
      "networking.gke.io/managed-certificates"         = "managed-cert"
      "networking.gke.io/v1beta1.FrontendConfig"       = "my-frontend-config"
    }
  }

  spec {
    rule {
      host = local.host
      http {
        path {
          path      = "/bff/"
          path_type = "Prefix"
          backend {
            service {
              name = "backend-for-frontend"
              port {
                number = 8080
              }
            }
          }
        }

        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "igs4eu-frontend"
              port {
                number = 3000
              }
            }
          }
        }
      }
    }
  }
}
