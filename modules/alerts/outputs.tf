output "uptime_check_ids" {
  description = "The IDs of all created uptime checks"
  value = merge(
    { for k, v in module.uptime-check-calculation : k => v.uptime_check_id },
    { for k, v in module.uptime-check-static-sites : k => v.uptime_check_id }
  )
}