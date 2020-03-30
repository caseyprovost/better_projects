FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "google" }
    password_confirmation { "google" }

    trait :confirmed do
      after(:create) do |user|
        user.confirm
        user.save!
      end
    end

    trait :locked do
      after(:create) do |user|
        user.lock_access!
      end
    end
  end
end
