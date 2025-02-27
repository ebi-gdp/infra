resource "google_storage_bucket" "public_buckets" {
  for_each = var.static_buckets

  name                        = "${each.value}-${var.environment}"
  location                    = var.region
  uniform_bucket_level_access = true
  storage_class               = "STANDARD"
  force_destroy               = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

resource "google_storage_bucket_iam_binding" "public_access" {
  for_each = google_storage_bucket.public_buckets

  bucket  = each.value.name
  role    = "roles/storage.objectViewer"
  members = ["allUsers"]
}
