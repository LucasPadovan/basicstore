ActionMailer::Base.smtp_settings = {
    address: APP_CONFIG['smtp']['address'],
    port: APP_CONFIG['smtp']['port'],
    domain: APP_CONFIG['smtp']['domain'],
    authentication: APP_CONFIG['smtp']['authentication'],
    user_name: APP_CONFIG['smtp']['user_name'],
    password: APP_CONFIG['smtp']['password'],
    enable_starttls_auto: true
}