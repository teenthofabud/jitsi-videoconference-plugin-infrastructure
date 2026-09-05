
// aiven pg service has to be created by hand and defaultdb will be created automatically
resource "aiven_pg_database" "primarydb" {
  project       = var.aiven_project
  service_name  = var.service_name
  database_name = var.database_name
  // OPTIONAL FIELDS
  lc_collate = "en_US.UTF-8" 
  lc_ctype   = "en_US.UTF-8" 
}