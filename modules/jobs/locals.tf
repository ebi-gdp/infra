locals {
  jobsubmitter_bucket = "geneticscores-${var.environment}-hattivatti"
  default_namespace   = "intervene-${var.environment}"
  namespaces          = toset(["intervene-${var.environment}", "kafka-${var.environment}"])
}