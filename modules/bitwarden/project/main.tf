resource "bitwarden_project" "project" {
  name            = var.project_name
  organization_id = var.org_id
}