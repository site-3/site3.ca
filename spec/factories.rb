FactoryGirl.define do
  sequence :email do |n|
    "email-#{n}@example.com"
  end
end
