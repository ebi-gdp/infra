locals {
  jobsubmitter_bucket = "geneticscores-${var.environment}-hattivatti"
  namespaces          = toset(["intervene-${var.environment}", "kafka-${var.environment}"])

  db_secret = templatefile("${path.module}/templates/database-secret.yaml.tfpl", {
    namespace = "intervene-${var.environment}"
    db_secret = var.db_secret
  })

  basic_auth = templatefile("${path.module}/templates/basic-auth-sec-passwd.yaml.tfpl", {
    namespace         = "intervene-${var.environment}"
    basic_auth_secret = var.basic_auth_secret
  })

  ega_aai = templatefile("${path.module}/templates/ega-aai-secret.yaml.tfpl", {
    namespace = "intervene-${var.environment}"
  })

  email_secret = templatefile("${path.module}/templates/email-secret.yaml.tfpl", {
    namespace    = "intervene-${var.environment}"
    email_secret = var.email_secret
  })

  globus_secret = templatefile("${path.module}/templates/globus-auth-secret.yaml.tfpl", {
    namespace     = "intervene-${var.environment}"
    globus_secret = var.globus_secret
  })

  s3_secret = templatefile("${path.module}/templates/s3-secret.yaml.tfpl", {
    namespace = "intervene-${var.environment}"
  })

  secrets = {
    "database-secret"              = local.db_secret
    "basic-auth-sec-passwd-secret" = local.basic_auth
    "ega-aai-secret"               = local.ega_aai
    "email-secret"                 = local.email_secret
    "globus-secret"                = local.globus_secret
    "s3-secret"                    = local.s3_secret
  }
}