FactoryGirl.define do
  factory :member do
    name { Faker::Name::name }
    email
    # this doesn't quite look like a Stripe customer id
    stripe_id { "cus_#{ SecureRandom.hex(7) }" }
    rfid { SecureRandom.hex(4) }
    password { Faker::Internet.password }

    trait :admin do
      admin true
    end
  end
end
