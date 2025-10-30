module "jitsi_vps" {
  source   = "./modules/aws/vpc"
  vpc_cidr = lookup(var.jitsi_vpc_cidr, terraform.workspace) #"10.10.10/10"
  vpc_tags = var.jitsi_vpc_tag
}

# Find the VPC main route table when there's no explicit subnet association
data "aws_route_table" "subnet_rt" {
  filter {
    name   = "association.main"
    values = ["true"]
  }
  filter {
    name   = "vpc-id"
    values = [module.jitsi_vps.vpc_id]
  }

  depends_on = [module.jitsi_vps]
}

module "jitsi_subnet" {
  source      = "./modules/aws/vpc/subnet"
  vpc_id      = module.jitsi_vps.vpc_id
  subnet_cidr = lookup(var.jitsi_subnet_cidr, terraform.workspace)
  subnet_tags = var.jitsi_subnet_tags
  depends_on  = [module.jitsi_vps]
}

module "jitsi_gateway_endpoint" {
  source                           = "./modules/aws/vpc/vpc_gateway_endpoint"
  gateway_endpoint_vpc_id          = module.jitsi_vps.vpc_id
  region                           = lookup(var.aws_region, terraform.workspace)
  gateway_endpoint_service_name    = lookup(var.jitsi_gateway_endpoint_service_name, terraform.workspace)
  gateway_endpoint_route_table_ids = [data.aws_route_table.subnet_rt.id] #lookup(var.jitsi_endpoint_route_table_ids, terraform.workspace)
  gateway_endpoint_tags = merge(
    var.jitsi_gateway_endpoint_tags,
    {
      "CreatedBy"   = "terraform"
      "Environment" = terraform.workspace
    }
  )
  depends_on = [module.jitsi_subnet]
}



# create JSON Output only

resource "null_resource" "jitsi_vpc_outputfile" {

  triggers = {
    jitsi_vpc_id                        = module.jitsi_vps.vpc_id
    jitsi_subnet_id                     = module.jitsi_subnet.subnet_id
    jitsi_endpoint_route_table_ids      = data.aws_route_table.subnet_rt.id
    jitsi_gateway_endpoint_service_name = module.jitsi_gateway_endpoint.vpc_endpoint_name
    jitsi_vpc_gateway_endpoint_type     = module.jitsi_gateway_endpoint.vpc_endpoint_type
    jitsi_vpc_gateway_endpoint_id       = module.jitsi_gateway_endpoint.vpc_endpoint_id
  }

  provisioner "local-exec" {
    command = <<EOT
echo "===== $(date '+%Y-%m-%d %H:%M:%S') =====" >> output.json
terraform output -json >> output.json
EOT
  }

  depends_on = [module.jitsi_vps, module.jitsi_subnet, module.jitsi_gateway_endpoint]
}