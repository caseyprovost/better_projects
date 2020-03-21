FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.password }
    password { "google" }
  end
end
