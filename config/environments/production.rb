require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Ensure static files (from public/assets) are served in production
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  # Sprockets asset pipeline settings
  config.assets.compile = false
  config.assets.prefix = "/assets"   

  # Active Storage - Amazon S3
  config.active_storage.service = :amazon

  # Force SSL
  config.force_ssl = true

  # Logging
  config.logger = ActiveSupport::Logger.new(STDOUT)
    .tap  { |logger| logger.formatter = ::Logger::Formatter.new }
    .then { |logger| ActiveSupport::TaggedLogging.new(logger) }
  config.log_tags = [ :request_id ]
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # I18n fallback
  config.i18n.fallbacks = true

  # Deprecations
  config.active_support.report_deprecations = false

  # DB schema dump
  config.active_record.dump_schema_after_migration = false

  # DNS rebinding protection (default settings OK)
  # config.hosts = [...]
  # config.host_authorization = { exclude: ->(request) { request.path == "/up" } }
end
