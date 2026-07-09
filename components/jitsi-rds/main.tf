module "db_subnet_group" {
  source = "../../modules/aws/rds/db_subnet_group"
  name       = "${var.context.name_prefix}-db-subnet-group"
  subnet_ids = var.private_subnet_ids
  tags = merge(
    var.context.common_tags,
    var.config.subnet_group.tags,
    {
      Name        = "${var.context.name_prefix}-db-subnet-group"
      Environment = var.context.environment
    }
  )
}

module "db_instance" {
  source = "../../modules/aws/rds/db_instance"
  identifier = "${var.context.name_prefix}-postgres"

  engine_version        = var.config.engine_version
  instance_class        = var.config.instance_class
  allocated_storage     = var.config.allocated_storage
  max_allocated_storage = var.config.max_allocated_storage
  storage_type          = var.config.storage_type

  db_name  = var.config.db_name
  username = var.config.username
  password = var.db_password

  db_subnet_group_name   = module.db_subnet_group.name
  vpc_security_group_ids = [var.rds_security_group_id]

  multi_az                = var.config.multi_az
  backup_retention_period = var.config.backup_retention_period
  preferred_backup_window = var.config.backup_window

  skip_final_snapshot       = var.config.skip_final_snapshot
  final_snapshot_identifier = "${var.context.name_prefix}-postgres-final"
  deletion_protection       = var.config.deletion_protection

  tags = merge(
    var.context.common_tags,
    var.config.tags,
    {
      Name        = "${var.context.name_prefix}-postgres"
      Environment = var.context.environment
    }
  )
}