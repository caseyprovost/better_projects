FactoryBot.define do
  factory :account do
    name { Faker::Team.unique.name.gsub(/\d|\s/, "") }
    active { true }
  end
end
