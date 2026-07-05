module "jitsi_vpc" {
  source = "../../modules/aws/vpc"
  vpc_cidr = var.config.vpc.cidr
  vpc_tags = merge(
    var.context.common_tags,
    var.config.vpc.tags,
    {
      Name        = "${var.context.name_prefix}-vpc"
      Environment = var.context.environment
    }
  )
}

module "private_subnet_a" {
  source = "../../modules/aws/vpc/subnet"
  vpc_id                  = module.jitsi_vpc.vpc_id
  subnet_cidr             = var.config.private_subnet_a.cidr
  availability_zone       = var.config.private_subnet_a.availability_zone
  map_public_ip_on_launch = false
  subnet_tags = merge(
    var.context.common_tags,
    var.config.private_subnet_a.tags,
    {
      Name        = "${var.context.name_prefix}-private-subnet-a"
      Environment = var.context.environment
    }
  )
  depends_on = [module.jitsi_vpc]
}

module "private_subnet_b" {
  source = "../../modules/aws/vpc/subnet"
  vpc_id                  = module.jitsi_vpc.vpc_id
  subnet_cidr             = var.config.private_subnet_b.cidr
  availability_zone       = var.config.private_subnet_b.availability_zone
  map_public_ip_on_launch = false
  subnet_tags = merge(
    var.context.common_tags,
    var.config.private_subnet_b.tags,
    {
      Name        = "${var.context.name_prefix}-private-subnet-b"
      Environment = var.context.environment
    }
  )
  depends_on = [module.jitsi_vpc]
}

module "private_route_table" {
  source = "../../modules/aws/vpc/route_table"
  vpc_id = module.jitsi_vpc.vpc_id
  route_table_tags = merge(
    var.context.common_tags,
    {
      Name        = "${var.context.name_prefix}-private-rt"
      Environment = var.context.environment
    }
  )
  depends_on = [module.jitsi_vpc]
}

module "private_subnet_a_route_table_association" {
  source = "../../modules/aws/vpc/route_table_association"
  subnet_id      = module.private_subnet_a.subnet_id
  route_table_id = module.private_route_table.route_table_id
}

module "private_subnet_b_route_table_association" {
  source = "../../modules/aws/vpc/route_table_association"
  subnet_id      = module.private_subnet_b.subnet_id
  route_table_id = module.private_route_table.route_table_id
}

module "lambda_security_group" {
  source = "../../modules/aws/vpc/security_group"
  name        = "${var.context.name_prefix}-lambda-sg"
  description = "Security group for Jitsi Lambda functions"
  vpc_id      = module.jitsi_vpc.vpc_id
  tags = merge(
    var.context.common_tags,
    {
      Name        = "${var.context.name_prefix}-lambda-sg"
      Environment = var.context.environment
    }
  )
}

module "rds_security_group" {
  source = "../../modules/aws/vpc/security_group"
  name        = "${var.context.name_prefix}-rds-sg"
  description = "Security group for Jitsi RDS PostgreSQL"
  vpc_id      = module.jitsi_vpc.vpc_id
  tags = merge(
    var.context.common_tags,
    {
      Name        = "${var.context.name_prefix}-rds-sg"
      Environment = var.context.environment
    }
  )
}

module "rds_ingress_from_lambda" {
  source = "../../modules/aws/vpc/security_group_rule"
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = module.rds_security_group.security_group_id
  source_security_group_id = module.lambda_security_group.security_group_id
  description              = "Allow PostgreSQL access from Lambda security group"
}

resource "null_resource" "jitsi_vpc_outputfile" {
  triggers = {
    jitsi_vpc_id                = module.jitsi_vpc.vpc_id
    private_subnet_a_id         = module.private_subnet_a.subnet_id
    private_subnet_b_id         = module.private_subnet_b.subnet_id
    private_route_table_id      = module.private_route_table.route_table_id
    lambda_security_group_id    = module.lambda_security_group.security_group_id
    rds_security_group_id       = module.rds_security_group.security_group_id
  }

  provisioner "local-exec" {
    command = <<EOT
    echo "===== $(date '+%Y-%m-%d %H:%M:%S') =====" >> output.json
    terraform output -json >> output.json
    EOT
  }

  depends_on = [
    module.jitsi_vpc,
    module.private_subnet_a,
    module.private_subnet_b,
    module.private_route_table,
    module.private_subnet_a_route_table_association,
    module.private_subnet_b_route_table_association,
    module.lambda_security_group,
    module.rds_security_group,
    module.rds_ingress_from_lambda
  ]
}