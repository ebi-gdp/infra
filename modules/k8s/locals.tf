locals {
  network_name = "${var.environment}-main-vpc"
  internal_dns = "internal-${var.environment}-app.dev"
  databases = {
    for key, database in module.databases :
    key => {
      static_ip                   = var.databases[key].private_address
      psc_service_attachment_link = database.instance_psc_attachment
      dns_name                    = database.dns_name
      instance_name               = key
    }
  }
  db_users = flatten([
    for db in module.databases : [
      for user in db.additional_users : {
        name                  = "cloudsql-${db.instance_name}-${user.name}",
        secret_data           = user.password,
        automatic_replication = false
      }
    ]
  ])
}