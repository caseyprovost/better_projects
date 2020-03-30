FactoryBot.define do
  factory :project do
    association :account
    name { Faker::Beer.name }
    status { "active" }
    description { Faker::Lorem.sentences(number: 3).join(" ") }

    after(:create) do |project|
      MessageBoard.create(project: project)
    end
  end
end
