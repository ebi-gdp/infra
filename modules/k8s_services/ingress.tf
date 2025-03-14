resource "kubernetes_ingress_v1" "app_ingress" {
  metadata {
    name      = "app-ingress-front-back-end-config"
    namespace = local.default_namespace

    annotations = {
      "kubernetes.io/ingress.global-static-ip-name"    = var.static_ip_name
      "networking.gke.io/managed-certificates"         = "managed-cert"
      "nginx.ingress.kubernetes.io/ssl-protocols"      = "TLSv1.2 TLSv1.3"
      "nginx.ingress.kubernetes.io/use-regex"          = "true"
      "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true"
      "nginx.ingress.kubernetes.io/ssl-redirect"       = "true"
      "kubernetes.io/ingress.class"                    = "gce"
      "nginx.ingress.kubernetes.io/server-snippet"     = <<-EOT
        rewrite ^/(.*)/$ /$1 permanent;
        add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;
      EOT
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
