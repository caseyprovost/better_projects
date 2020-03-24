FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.password }
    password { "google" }
    password_confirmation { "google" }

    trait :confirmed do
      after(:create) do |user|
        user.confirm
      end
    end
  end
end
