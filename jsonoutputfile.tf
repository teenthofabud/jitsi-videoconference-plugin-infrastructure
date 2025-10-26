# This file is to create JSON Output only

resource "null_resource" "outputfile" {

  triggers = {
    # bitwarden_project_name = module.jitsi-project.project_name
    s3_bucket_id_for_static_web  = module.jitsi_static_web.bucket_id
    s3_bucket_arn_for_static_web = module.jitsi_static_web.bucket_arn
    s3_static_web_endpoint       = module.jitsi_static_web.website_endpoint
  }

  provisioner "local-exec" {
    command = <<EOT
echo "===== $(date '+%Y-%m-%d %H:%M:%S') =====" >> output.json
terraform output -json >> output.json
EOT
  }
}