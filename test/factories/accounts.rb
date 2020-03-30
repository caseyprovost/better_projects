FactoryBot.define do
  factory :account do
    name { Faker::Team.name }
    active { true }
  end
end
