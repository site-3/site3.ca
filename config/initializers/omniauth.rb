Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
    Rails.application.secrets.facebook_app_key,
    Rails.application.secrets.facebook_app_secret
end
