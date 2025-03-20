locals {
  db_secret_name = "cloudsql-intervene-${var.environment}-intervene-${var.environment}"
  db_username    = "intervene-${var.environment}"
}
