locals {
  jobsubmitter_bucket = "geneticscores-${var.environment}-hattivatti"
  namespaces          = toset(["intervene-${var.environment}", "kafka-${var.environment}"])
  default_namespace   = "intervene-${var.environment}"

  host_environments = {
    dev  = "dev.geneticscores.org"
    test = "test.geneticscores.org"
    prod = "calculate.geneticscores.org"
  }
  host = local.host_environments[var.environment]

  db_secret = templatefile("${path.module}/templates/database-secret.yaml.tfpl", {
    namespace = local.default_namespace
    db_secret = var.db_secret
  })

  basic_auth = templatefile("${path.module}/templates/basic-auth-sec-passwd.yaml.tfpl", {
    namespace         = local.default_namespace
    basic_auth_secret = var.basic_auth_secret
  })

  ega_aai = templatefile("${path.module}/templates/ega-aai-secret.yaml.tfpl", {
    namespace = local.default_namespace
  })

  email_secret = templatefile("${path.module}/templates/email-secret.yaml.tfpl", {
    namespace    = local.default_namespace
    email_secret = var.email_secret
  })

  globus_secret = templatefile("${path.module}/templates/globus-auth-secret.yaml.tfpl", {
    namespace     = local.default_namespace
    globus_secret = var.globus_secret
  })

  s3_secret = templatefile("${path.module}/templates/s3-secret.yaml.tfpl", {
    namespace = local.default_namespace
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