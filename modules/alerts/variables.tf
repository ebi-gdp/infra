variable "project_id" {
  description = "The GCP project to deploy the infrastructure"
  type        = string
  nullable    = false
}

variable "environment" {
  description = "Deployment environment"
  type        = string

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Allowed values for input_parameter are \"dev\", \"test\", or \"prod\"."
  }
}

variable "uptime_targets" {
  description = "Public uptime check targets (static sites)"
  type        = map(string)
  default = {
    "geneticscores.org"                            = "GeneticScores.org landing page"
    "methods.geneticscores.org"                    = "GeneticScores.org methods comparison"
    "docs.geneticscores.org"                       = "GeneticScores.org documentation"
    "calculate.geneticscores.org"                  = "GeneticScores.org calculation service"
    "intervenegeneticscores.org"                   = "intervenegeneticscores.org permanent redirect"
    "methodscomparison.intervenegeneticscores.org" = "methodscomparison.intervenegeneticscores.org permanent redirect"
  }
}

variable "calculation_uptime_targets" {
  description = "Public uptime check targets (calculation service)"
  type        = map(string)
  default = {
    "/bff/actuator/health"                  = "Calculation service: Backend for frontend"
    "/bff/pipeline-manager/actuator/health" = "Calculation service: Pipeline manager"
    "/bff/user-manager/actuator/health"     = "Calculation service: User manager"
    "/bff/key-handler/actuator/health"      = "Calculation service: Key handler"
  }
}

variable "alert_contacts" {
  description = "Alert contacts (format: email = description)"
  type        = map(string)
}