require 'yaml'

APP_CONFIG = YAML.load_file("#{Rails.root}/config/app_config.yml")[Rails.env]

RAINBOW_COLORS = %w(red orange yellow green light_blue blue)