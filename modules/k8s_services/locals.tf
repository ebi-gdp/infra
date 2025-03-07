locals {
  jobsubmitter_bucket = "geneticscores-${var.environment}-hattivatti"
  namespaces          = toset(["intervene-${var.environment}", "kafka-${var.environment}"])
}