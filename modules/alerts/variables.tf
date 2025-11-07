variable "project_id" {
  description = "The GCP project to deploy the infrastructure"
  type        = string
  nullable    = false
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

variable "notification_channel" {
  description = "Notification channel ID"
  type        = string
}