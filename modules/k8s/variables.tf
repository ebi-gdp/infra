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

variable "oidc_service_accounts" {
  description = "service account in the GKE cluster to use GCP services"
  default     = {}
  type = map(object({
    roles               = list(string)
    namespace           = string
    use_existing_k8s_sa = optional(bool, true)
    annotate_k8s_sa     = optional(bool, false)
  }))
}

variable "horizontal_pod_autoscaling" {
  default = true
  type    = bool
}

variable "subnets" {
  description = "Subnets to create on the VPC"
  type = list(object({
    subnet_name           = string
    subnet_ip             = string
    subnet_region         = string
    subnet_private_access = optional(bool, true)
    description           = string
  }))
}

variable "secondary_ranges" {
  description = "GKE secondary ranges"
  type = map(list(object({
    range_name    = string
    ip_cidr_range = string
  })))
}

variable "default_azs" {
  description = "The default zones for the GKE clusters"
  default     = ["europe-west2-a", "europe-west2-b", "europe-west2-c"]
  type        = list(string)
}

variable "cluster_deletion_protection" {
  type        = bool
  default     = "false"
  description = "Protect the cluster against deletion"
}

variable "master_ipv4_cidr_block" {
  type    = string
  default = "10.0.0.0/28"
}

variable "enable_private_nodes" {
  type    = bool
  default = true
}

variable "grant_registry_access" {
  type    = bool
  default = false
}

variable "databases" {
  description = "SQL instances to be created in the project. Each item is a SQL instance"
  type = map(object({
    private_address                 = string
    maintenance_window_update_track = optional(string, "stable")
    maintenance_window_hour         = optional(number, 12)
    maintenance_window_day          = optional(number, 6)
    deletion_protection_enabled     = optional(bool, true)
    availability_type               = optional(string, "ZONAL")
    additional_users = optional(list(object({
      name            = string
      password        = string
      random_password = bool
    })), [])
    ipv4_enabled     = optional(bool, false)
    psc_enabled      = optional(bool, true)
    database_version = optional(string, "POSTGRES_15")
    primary_az       = optional(string, "europe-west2-a")
    instance_type    = optional(string, "db-f1-micro")
    name             = optional(string, "")
    secondary_az     = optional(string, "europe-west2-b")
    database_charset = optional(string, "UTF8")
    additional_databases = optional(list(object({
      name      = string
      charset   = string
      collation = string
    })), [])
    database_collation = optional(string, "en_US.UTF8")
    database_flags     = optional(any, [{ name = "autovacuum", value = "off" }])
    insights_config = optional(any, {
      query_insights_enabled  = true,
      query_plans_per_minute  = 5,
      query_string_length     = 1024,
      record_application_tags = false,
      record_client_address   = false,
    })
    backup_configuration = optional(any, {
      enabled                        = true
      start_time                     = "00:00"
      location                       = null
      point_in_time_recovery_enabled = false
      transaction_log_retention_days = null
      retained_backups               = 1
      retention_unit                 = "COUNT"
    })
  }))
}

variable "use_sql_proxy" {
  description = "Use cloud proxy to connect to the Cloud SQL database"
  default     = false
  type        = bool
}
