# ----      Bitwarden      ---- #

module "jitsi-project" {
  source       = "./modules/bitwarden/project"
  project_name = lookup(var.project_name, terraform.workspace, "demo")
  org_id       = lookup(var.org_id, terraform.workspace)

}

# ----      Output Files     ---- #

resource "null_resource" "bitwarden_output" {

  triggers = {
    bitwarden_project_name = module.jitsi-project.project_name
  }


  provisioner "local-exec" {
    command = <<EOT
echo "===== $(date '+%Y-%m-%d %H:%M:%S') =====" >> output.json
terraform output -json >> output.json
EOT
  }
}