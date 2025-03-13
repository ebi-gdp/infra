locals {
  jobsubmitter_bucket = "geneticscores-${var.environment}-hattivatti"
  namespaces          = toset(["intervene-${var.environment}", "kafka-${var.environment}"])

  db_manifest = templatefile("${path.module}/templates/database-secret.yaml.tfpl", {
    namespace = "intervene-${var.environment}"
    db_secret = var.db_secret
  })

}