# see tf example here https://cloud.google.com/load-balancing/docs/https/setup-global-ext-https-buckets

// google managed certs config

resource "google_compute_managed_ssl_certificate" "default" {
  name = "genetic-scores-org"

  managed {
    domains = ["www.geneticscores.org", "geneticscores.org", "docs.geneticscores.org", "methods.geneticscores.org"]
  }
}

resource "google_compute_ssl_policy" "modern_ssl" {
  name            = "modern-ssl-policy"
  min_tls_version = "TLS_1_2"
  profile         = "MODERN"
}

// https load balancer set up with backend buckets

resource "google_compute_target_https_proxy" "default" {
  name             = "https-proxy"
  url_map          = google_compute_url_map.default.id
  ssl_certificates = [google_compute_managed_ssl_certificate.default.id]
  ssl_policy       = google_compute_ssl_policy.modern_ssl.id
}

resource "google_compute_url_map" "default" {
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

resource "google_compute_global_forwarding_rule" "default" {
  name       = "https-forwarding-rule"
  target     = google_compute_target_https_proxy.default.id
  ip_address = var.static_ip.address
  port_range = 443
}

// automatic redirect HTTP -> HTTPS

resource "google_compute_url_map" "http_redirect" {
  name = "http-redirect-url-map"

  default_url_redirect {
    https_redirect         = true
    strip_query            = false
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
  }
}

resource "google_compute_target_http_proxy" "http_redirect" {
  name    = "http-redirect-proxy"
  url_map = google_compute_url_map.http_redirect.id
}

resource "google_compute_global_forwarding_rule" "http_redirect_rule" {
  name       = "http-redirect-rule"
  target     = google_compute_target_http_proxy.http_redirect.id
  ip_address = var.static_ip.address
  port_range = "80"
}