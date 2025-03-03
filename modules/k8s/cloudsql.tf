
/* This file contains the resources needed to create a Cloud SQL instance with a private IP within the network_vpc resource
https://gitlab.ebi.ac.uk/wap-public/ebi-iac/infrastructure-stacks/-/blob/63b70ba8389eb177fecab2579604e7a6059f651f/terraform/gcp/light-data-presentation-stack/modules/presentation-stack/cloudsql.tf
*/

module "databases" {
  for_each = var.databases
  source   = "terraform-google-modules/sql-db/google//modules/postgresql"
  version  = "25.2"

  name                 = each.key
  random_instance_name = true
  project_id           = var.project_id
  database_version     = each.value.database_version
  region               = var.region

  // Master configurations
  tier                            = each.value.instance_type
  zone                            = each.value.primary_az
  secondary_zone                  = each.value.secondary_az
  availability_type               = each.value.availability_type
  maintenance_window_day          = each.value.maintenance_window_day
  maintenance_window_hour         = each.value.maintenance_window_hour
  maintenance_window_update_track = each.value.maintenance_window_update_track

  // deletion policies
  deletion_protection         = each.value.deletion_protection_enabled
  database_deletion_policy    = "ABANDON"
  deletion_protection_enabled = each.value.deletion_protection_enabled
  database_flags              = each.value.database_flags
  user_deletion_policy        = "ABANDON"

  ip_configuration = {
    ipv4_enabled = each.value.ipv4_enabled
    psc_enabled  = each.value.psc_enabled
    // must include the project where the sql instance is deployed
    psc_allowed_consumer_projects = [var.project_id]
  }
  insights_config      = each.value.insights_config
  backup_configuration = each.value.backup_configuration

  db_name      = each.key
  db_charset   = each.value.database_charset
  db_collation = each.value.database_collation

  additional_databases = each.value.additional_databases

  enable_default_user = true
  additional_users    = each.value.additional_users
}

// Creating the private connection to the database
module "psc_connections" {
  source        = "gitlab.ebi.ac.uk/wap-public/google-service-private-connect-sql/gcp"
  version       = "0.0.2"
  env           = var.environment
  region        = var.region
  network_id    = module.network_vpc.network_id
  subnetwork_id = "${var.environment}-main-subnet"
  use_sql_proxy = var.use_sql_proxy
  internal_dns  = local.internal_dns
  sql_instances = local.databases

  depends_on = [module.network_vpc, module.network_subnets]
}
