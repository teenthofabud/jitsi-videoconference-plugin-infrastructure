locals {

  aiven_service_ping_environment_variables = var.config.db_ping.enable_db_ping ? {
    DB_USERNAME = var.config.aiven_ping_db_config.username
    DB_PASSWORD = var.config.aiven_ping_db_config.password
    DB_URI      = var.config.aiven_ping_db_config.url
  } : {}

  moderator_service_environment_variables = {
    JITSI_DB_USERNAME = var.config.moderator_db_config.username
    JITSI_DB_PASSWORD = var.config.moderator_db_config.password
    JITSI_DB_URL      = var.config.moderator_db_config.url
    JITSI_DB_DIALECT  = "org.hibernate.dialect.PostgreSQLDialect"
    JITSI_DB_DRIVER_CLASS = "org.postgresql.Driver"
    AUTH0_API_IDENTIFIER = var.config.auth0.api_identifier
    AUTH0_DOMAIN = var.config.auth0.domain
    JITSI_HIKARI_MAX_POOL_SIZE = var.config.moderator.spring_config.hikari_max_pool_size
    JITSI_HIKARI_MIN_IDLE_COUNT = var.config.moderator.spring_config.hikari_min_idle_count
  }
}