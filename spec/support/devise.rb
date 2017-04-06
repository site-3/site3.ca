RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
end

def set_devise_mapping(mapping)
  @request.env["devise.mapping"] = Devise.mappings[mapping]
end
