variable "project_id" {
  description = "The GCP project to deploy the infrastructure"
  type        = string
  nullable    = false
}

variable "region" {
  type    = string
  default = "europe-west2"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "autopilot_endpoint" {
  type = string
}

variable "autopilot_ca_certificate" {
  type = string
}

variable "static_ip_name" {
  type        = string
  description = "Name of static ip used for kubernetes ingress"
}

variable "db_secret" {
  description = "Username/password for CloudSQL database"
  type = object({
    DB_USERNAME = string
    DB_PASSWORD = string
  })
  sensitive = true
}

variable "basic_auth_secret" {
  description = "Configuration for microservices using basic access authentication"
  type = object({
    BASIC_AUTH_USERNAME = string
    BASIC_AUTH_PASSWORD = string
    SEC_KEY_PASSWORD    = string
  })
  sensitive = true
}


variable "email_secret" {
  description = "Configuration for email notifications"
  type = object({
    INTERVENE_EMAIL_ID       = string
    INTERVENE_EMAIL_PASSWORD = string
  })
  sensitive = true
}

variable "globus_secret" {
  description = "Configuration for globus authentication"
  type = object({
    GLOBUS_CLIENT_ID     = string
    GLOBUS_CLIENT_SECRET = string
  })
  sensitive = true
}


variable "oidc_service_accounts" {
  description = "service account in the GKE cluster to use GCP services"
  type = map(object({
    roles                           = list(string)
    namespace                       = string
    use_existing_k8s_sa             = optional(bool, false)
    automount_service_account_token = optional(bool, false)
  }))
}

variable "gitlab_project_ids" {
  description = "Project IDs with Gitlab Ci/CD pipelines that need to read from the GCP secret manager"
  type = object(
    {
      backend_for_frontend_gateway = string
      platform                     = string
    }
  )
  default = {
    backend_for_frontend_gateway = "4766"
    platform                     = "4654"
  }
}

variable "alert_contact" {
  description = "Alert contact"
  type        = string
  default     = "gdp-dev@ebi.ac.uk"
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
