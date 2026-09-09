resource "google_compute_managed_ssl_certificate" "calculation_retirement" {
  name = "calculation-retirement"

  managed {
    domains = ["calculate.geneticscores.org"]
  }
}

resource "google_compute_ssl_policy" "calculation_retirement" {
  name            = "calculation-retirement-ssl"
  profile         = "MODERN"
  min_tls_version = "TLS_1_2"
}

resource "google_compute_url_map" "calculation_retirement_https" {
  name = "calculation-retirement-https"

  default_url_redirect {
    host_redirect          = "geneticscores.org"
    path_redirect          = "/posts/calculation-service-retired/"
    strip_query            = true
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
  }
}

resource "google_compute_target_https_proxy" "calculation_retirement" {
  name             = "calculation-retirement-https"
  url_map          = google_compute_url_map.calculation_retirement_https.id
  ssl_certificates = [google_compute_managed_ssl_certificate.calculation_retirement.id]
  ssl_policy       = google_compute_ssl_policy.calculation_retirement.id
}

resource "google_compute_global_forwarding_rule" "calculation_retirement_https" {
  name       = "calculation-retirement-https"
  target     = google_compute_target_https_proxy.calculation_retirement.id
  ip_address = data.google_compute_global_address.calculation_service_lb_ip.address
  port_range = "443"
}

resource "google_compute_url_map" "calculation_retirement_http" {
  name = "calculation-retirement-http"

  default_url_redirect {
    host_redirect          = "geneticscores.org"
    path_redirect          = "/posts/calculation-service-retired/"
    https_redirect         = true
    strip_query            = true
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
  }
}

resource "google_compute_target_http_proxy" "calculation_retirement" {
  name    = "calculation-retirement-http"
  url_map = google_compute_url_map.calculation_retirement_http.id
}

resource "google_compute_global_forwarding_rule" "calculation_retirement_http" {
  name       = "calculation-retirement-http"
  target     = google_compute_target_http_proxy.calculation_retirement.id
  ip_address = data.google_compute_global_address.calculation_service_lb_ip.address
  port_range = "80"
}
