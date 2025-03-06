terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
    kubernetes = {
      source  = "hashicorp/google"
      version = "~> 2.3"
    }
  }
}