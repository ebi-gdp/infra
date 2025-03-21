terraform {
  backend "gcs" {
    bucket = "genetic-scores-tofu-state"
    prefix = "prod-services"
  }
}