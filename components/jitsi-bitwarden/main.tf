module "jitsi_project" {
  source = "../../modules/bitwarden/project"
  project_name = var.context.project_name
  org_id       = var.config.org_id
}

# This file is to create JSON Output only
resource "null_resource" "bitwarden_outputfile" {
  triggers = {
    bitwarden_project_name = module.jitsi_project.project_name
  }
  provisioner "local-exec" {
    command = <<EOT
    echo "===== $(date '+%Y-%m-%d %H:%M:%S') =====" >> output.json
    terraform output -json >> output.json
    EOT
  }
  depends_on = [module.jitsi_project]
}