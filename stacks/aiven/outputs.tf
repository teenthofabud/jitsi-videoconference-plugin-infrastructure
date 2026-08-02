output "service_host" {
  value = aiven_pg.jitsi.service_host
}

output "service_port" {
  value = aiven_pg.jitsi.service_port
}

output "database_name" {
  value = aiven_pg.jitsi.pg.dbname
}

output "service_username" {
  value = aiven_pg.jitsi.service_username
}

output "service_password" {
  value     = aiven_pg.jitsi.service_password
  sensitive = true
}

output "service_uri" {
  value     = aiven_pg.jitsi.service_uri
  sensitive = true
}