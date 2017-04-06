# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  address: 'smtp.sendgrid.net',
  port: 587,
  user_name: 'apikey',
  password: Rails.application.secrets.sendgrid_api_key,
  domain: Rails.application.secrets.mailer_host,
  authentication: :plain,
  enable_starttls_auto: true,
}
