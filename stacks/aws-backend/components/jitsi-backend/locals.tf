locals {

  aiven_service_ping_environment_variables = var.config.db_ping.enable_db_ping ? {
    DB_USERNAME = var.config.aiven_ping_db_config.username
    DB_PASSWORD = var.config.aiven_ping_db_config.password
    DB_URI      = var.config.aiven_ping_db_config.url
  } : {}

  moderator_service_environment_variables = {
    MODERATOR_DB_USERNAME = var.config.moderator_db_config.username
    MODERATOR_DB_PASSWORD = var.config.moderator_db_config.password
    MODERATOR_DB_NAME      = var.config.moderator_db_config.db_name
    MODERATOR_SCHEMA_NAME = var.config.moderator_db_config.schema
    SPRING_DATASOURCE_HIKARI_SCHEMA = var.config.moderator_db_config.schema
    MODERATOR_DB_HOST = var.config.moderator_db_config.host
    MODERATOR_DB_PORT = var.config.moderator_db_config.port
    # MODERATOR_DB_DIALECT  = "org.hibernate.dialect.PostgreSQLDialect"
    # MODERATOR_DB_DRIVER_CLASS = "org.postgresql.Driver"
    AUTH0_API_IDENTIFIER = var.config.auth0.api_identifier
    AUTH0_DOMAIN = var.config.auth0.domain
    MODERATOR_HIKARI_MAX_POOL_SIZE = var.config.moderator.spring_config.hikari_max_pool_size
    MODERATOR_HIKARI_MIN_IDLE_COUNT = var.config.moderator.spring_config.hikari_min_idle_count
  }
}