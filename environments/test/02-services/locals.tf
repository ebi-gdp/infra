locals {
  db_secret_name = "cloudsql-intervene-${var.environment}-intervene-${var.environment}"
  db_username    = "intervene-${var.environment}"
  // remove any newlines from heredoc strings
  basic_auth_secret = { for key, value in var.basic_auth_secret : key => chomp(value) }
}
