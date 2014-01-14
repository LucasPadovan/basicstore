require 'yaml'

RAINBOW_COLORS = %w(red orange yellow green lightBlue cyan blue violet)
APP_CONFIG = YAML.load_file("#{Rails.root}/config/app_config.yml")[Rails.env]

module Tienda
  class Application < Rails::Application
    config.after_initialize do
      Tienda::Application.configure do
        config.action_mailer.delivery_method = :smtp
        config.action_mailer.smtp_settings = {
            address: APP_CONFIG['smtp']['address'],
            port: APP_CONFIG['smtp']['port'],
            domain: APP_CONFIG['smtp']['domain'],
            authentication: APP_CONFIG['smtp']['authentication'],
            user_name: APP_CONFIG['smtp']['user_name'],
            password: APP_CONFIG['smtp']['password'],
            enable_starttls_auto: true
        }
      end
    end
  end
end

