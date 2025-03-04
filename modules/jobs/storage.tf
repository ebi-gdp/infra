module "bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~> 9.1"

  name                     = local.jobsubmitter_bucket
  project_id               = var.project_id
  location                 = var.region
  public_access_prevention = "enforced"
}