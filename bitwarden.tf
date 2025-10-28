# ----      Bitwarden      ---- #

module "jitsi_project" {
  source       = "./modules/bitwarden/project"
  project_name = lookup(var.project_name, terraform.workspace, "demo")
  org_id       = lookup(var.org_id, terraform.workspace)
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