RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
end

def set_devise_mapping(mapping)
  @request.env["devise.mapping"] = Devise.mappings[mapping]
end
