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
}