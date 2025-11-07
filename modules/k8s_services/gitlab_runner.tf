locals {
  create_runner = var.gitlab_runner_token == "" ? 0 : 1
  preffix = try(random_string.preffix[0].result, "")
  helm_release_name = "${local.preffix}-gitlab-runner"
  gitlab_runners_namespace_name = "gitlab-runner-${var.environment}"
}

resource "random_string" "preffix" {
  count   = local.create_runner
  length  = 2
  special = false
  upper   = false
  numeric = false
}

resource "kubernetes_namespace" "gitlab_runner" {
  count = local.create_runner
  metadata {
    name = local.gitlab_runners_namespace_name
    labels = { name = local.gitlab_runners_namespace_name }
  }
}

resource "helm_release" "gitlab_runner" {
  count      = local.create_runner
  name       = local.helm_release_name
  repository = "http://charts.gitlab.io"
  chart      = "gitlab-runner"
  version    = var.gitlab_runner_chart_version
  namespace  = kubernetes_namespace.gitlab_runner[count.index].metadata.0.name
  values = [ templatefile("${path.module}/gitlab_runner_chart/values.yaml", {
      concurrency       = var.gitlab_runner_config.concurrency
      // set the limits through variables. 
      helper_limits     = var.gitlab_runner_config.helper_limits
      job_limits        = var.gitlab_runner_config.job_limits
      service_limits    = var.gitlab_runner_config.service_limits
      controller_limits = var.gitlab_runner_config.controller_limits
      token             = google_secret_manager_secret_version.gitlab_token_version[0].secret_data
      gitlab_url        = var.gitlab_runner_config.gitlab_url
    })
  ]
  depends_on = [ kubernetes_namespace.gitlab_runner ]
}

resource "google_secret_manager_secret" "gitlab_token" {
  count = local.create_runner
  secret_id = "gitlab_runner_token"
  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "gitlab_token_version" {
  count = local.create_runner
  secret      = google_secret_manager_secret.gitlab_token[0].id
  secret_data = var.gitlab_runner_token
}

// important for GitLab pipelines to read from GCP secret manager
resource "google_secret_manager_secret_iam_binding" "gitlab_secret_access_access_token" {
  count = local.create_runner
  secret_id = google_secret_manager_secret.gitlab_token[0].id
  role      = "roles/secretmanager.secretAccessor"
  members = [
    for key, project_id in var.gitlab_project_ids : "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.gitlab.name}/attribute.gitlab_project_id/${project_id}"
  ]
}