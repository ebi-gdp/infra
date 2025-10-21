data "terraform_remote_state" "services" {
  backend = "gcs"

  config = {
    bucket = "genetic-scores-tofu-state"
    prefix = "dev-services"
  }
}

module "alerts" {
  source               = "../../../modules/alerts"
  project_id           = var.project_id
  // added because the output wasn't found on the data object
  notification_channel = "projects/prj-ext-dev-intervene-413412/notificationChannels/18089544846530368587"
  uptime_targets = {}
  logging_metrics = {
    default = {
      filter =<<EOF
        resource.type="k8s_container" 
        AND resource.labels.namespace_name="default" 
        AND severity=ERROR
      EOF
    }
    intervene-dev = {
      filter =<<EOF
      resource.type="k8s_container" 
      AND resource.labels.namespace_name="intervene-dev"
      AND severity = "ERROR"
      NOT textPayload : "Checking for deployed jobs for timeout"
      NOT textPayload : "Checking for expired buckets"
      NOT textPayload : "Checking for timed out jobs"
      NOT labels."k8s-pod/job-name" : "pgs-ids-pub-data-update-cron"
      NOT resource.labels.container_name = "init-redis"
      NOT resource.labels.container_name = "user-manager"
      EOF
    }
  }
}