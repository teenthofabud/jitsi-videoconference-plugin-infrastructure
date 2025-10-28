module "jitsi_vps" {
  source   = "./modules/aws/vpc"
  vpc_cidr = lookup(var.jitsi_vpc_cidr, terraform.workspace) #"10.10.10/10"
  vpc_tags = var.jitsi_vpc_tag
}

module "jitsi_subnet" {
  source      = "./modules/aws/vpc/subnet"
  vpc_id      = module.jitsi_vps.vpc_id
  subnet_cidr = lookup(var.jutsi_subnet_cidr, terraform.workspace)
  subnet_tags = var.jitsi_subnet_tags

  depends_on = [module.jitsi_vps]
}

# create JSON Output only

resource "null_resource" "jitsi_vpc_outputfile" {

  triggers = {
    jitsi_vpc_id    = module.jitsi_vps.vpc_id
    jitsi_subnet_id = module.jitsi_subnet.subnet_id
  }

  provisioner "local-exec" {
    command = <<EOT
echo "===== $(date '+%Y-%m-%d %H:%M:%S') =====" >> output.json
terraform output -json >> output.json
EOT
  }

  depends_on = [module.jitsi_vps, module.jitsi_subnet]
}