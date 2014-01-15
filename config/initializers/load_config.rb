require 'yaml'

RAINBOW_COLORS = %w(red orange yellow green lightBlue cyan blue violet)
APP_CONFIG = YAML.load_file("#{Rails.root}/config/app_config.yml")[Rails.env]
