resource "aiven_pg" "jitsi" {
  project      = var.aiven_project
  service_name = var.service_name
  plan         = var.plan
  cloud_name = var.db_cloud_name
  termination_protection = var.termination_protection

  dynamic "tech_emails" {
    for_each = var.tech_emails

    content {
      email = tech_emails.value
    }
  }
}