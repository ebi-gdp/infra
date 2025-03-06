
// set up kubernetes service accounts with workload identity management
// see https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity

resource "kubernetes_service_account" "hattivatti" {
  metadata {
    namespace = local.default_namespace
    name      = "hattivatti"
  }
}

resource "google_project_iam_member" "hattivatti-roles" {
  role    = "roles/storage.admin"
  project = var.project_id
  member  = "principal://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${var.project_id}.svc.id.goog/subject/ns/${local.default_namespace}/sa/hattivatti"
}

resource "kubernetes_service_account" "nextflow" {
  metadata {
    namespace = local.default_namespace
    name      = "nextflow"
  }
}

resource "google_project_iam_member" "nextflow-roles" {
  // https://seqera.io/blog/nextflow-with-gbatch/
  for_each = toset([
    "roles/batch.jobsEditor",
    "roles/iam.serviceAccountUser",
    "roles/logging.viewer",
    "roles/storage.admin"
  ])

  role    = each.key
  project = var.project_id
  member  = "principal://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${var.project_id}.svc.id.goog/subject/ns/${local.default_namespace}/sa/nextflow"
}

// backend services

resource "kubernetes_service_account" "backend" {
  metadata {
    namespace = local.default_namespace
    name      = "gcp-service-api"
  }
}

resource "google_project_iam_member" "backend-roles" {
  for_each = toset([
    "roles/cloudsql.client",
    "roles/cloudsql.instanceUser",
    "roles/secretmanager.admin",
    "roles/storage.admin"
  ])

  role    = each.key
  project = var.project_id
  member  = "principal://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${var.project_id}.svc.id.goog/subject/ns/${local.default_namespace}/sa/gcp-service-api"
}
