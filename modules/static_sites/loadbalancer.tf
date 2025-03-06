# see tf example here https://cloud.google.com/load-balancing/docs/https/setup-global-ext-https-buckets

terraform {
  required_version = ">= 1.0.0, < 2.0.0"
}

resource "google_compute_global_address" "static_lb_ip" {
  name = "static-lb-ip"
}

resource "google_compute_url_map" "static_site_url_map" {
  name        = "static-site-url-map"
  description = "URL map for the static sites with bucket backends"

  default_service = google_compute_backend_bucket.public_backends["geneticscores.org"].id

  dynamic "host_rule" {
    for_each = var.static_buckets
    content {
      hosts        = [host_rule.key]
      path_matcher = host_rule.value
    }
  }

  dynamic "path_matcher" {
    for_each = var.static_buckets
    content {
      name            = path_matcher.value
      default_service = google_compute_backend_bucket.public_backends[path_matcher.key].id

      path_rule {
        paths   = ["/*"]
        service = google_compute_backend_bucket.public_backends[path_matcher.key].id
      }
    }
  }
}

resource "google_compute_target_http_proxy" "static-sites" {
  name    = "http-lb-proxy"
  url_map = google_compute_url_map.static_site_url_map.id
}

resource "google_compute_global_forwarding_rule" "default" {
  name                  = "http-lb-forwarding-rule"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "80"
  target                = google_compute_target_http_proxy.static-sites.id
  ip_address            = google_compute_global_address.static_lb_ip.id
}