output "service_host" {
  value = aiven_pg.jitsi.service_host
  sensitive = true
}

output "service_port" {
  value = aiven_pg.jitsi.service_port
  sensitive = true
}

output "database_name" {
  value = aiven_pg.jitsi.pg[0].dbname
  sensitive = true
}

output "service_username" {
  value = aiven_pg.jitsi.service_username
  sensitive = true
}

output "service_password" {
  value     = aiven_pg.jitsi.service_password
  sensitive = true
}

output "service_uri" {
  value     = aiven_pg.jitsi.service_uri
  sensitive = true
}