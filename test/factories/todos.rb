FactoryBot.define do
  factory :todo do
    transient do
    end

    association :todo_list
    association :creator, factory: :user
    title { Faker::Book.title }
    description { Faker::Lorem.paragraph }
    completed { false }
  end
end
