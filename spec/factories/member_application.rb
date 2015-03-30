FactoryGirl.define do
  factory :member_application do
    name { Faker::Name::name }
    email
  end
end
