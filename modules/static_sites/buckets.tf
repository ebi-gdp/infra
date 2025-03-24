// create buckets for static sites

resource "google_storage_bucket" "public_buckets" {
  for_each = var.static_buckets

  name                        = each.value
  location                    = var.region
  uniform_bucket_level_access = true
  storage_class               = "STANDARD"
  force_destroy               = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

// make buckets publicly available on the internet

resource "google_storage_bucket_iam_binding" "public_access" {
  for_each = google_storage_bucket.public_buckets

  bucket  = each.value.name
  role    = "roles/storage.objectViewer"
  members = ["allUsers"]
}

// set up load balancer backend for buckets

resource "google_compute_backend_bucket" "public_backends" {
  for_each    = google_storage_bucket.public_buckets
  name        = each.value.name
  bucket_name = each.value.name
  enable_cdn  = true

  custom_response_headers = [
    "Strict-Transport-Security: max-age=63072000; includeSubDomains; preload",
  ]
}