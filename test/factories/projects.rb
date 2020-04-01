FactoryBot.define do
  factory :project do
    association :account
    sequence(:name) { |n| "#{Faker::Beer.name}-#{n}" }
    status { "active" }
    description { Faker::Lorem.sentences(number: 3).join(" ") }
  end
end
