resource "google_compute_backend_bucket" "public_backends" {
  for_each    = google_storage_bucket.public_buckets
  name        = each.value.name
  bucket_name = each.value.name
  enable_cdn  = true

  custom_response_headers = [
    "Strict-Transport-Security: max-age=63072000; includeSubDomains; preload",
  ]
}