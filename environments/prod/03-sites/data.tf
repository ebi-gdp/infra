/*
- IP address lifecycle shouldn't be managed by terraform
- We create them manually because changing DNS mapping is a manual process currently
- A data block means that terraform can read the IP address and pass it to other resources
*/

data "google_compute_global_address" "static_site_lb_ip" {
  name = "geneticscores-prod-static-ip"
}

data "google_compute_global_address" "calculation_service_lb_ip" {
  name = "intervene-prod-static-ip"
}
