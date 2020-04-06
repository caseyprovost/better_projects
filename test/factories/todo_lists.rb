FactoryBot.define do
  factory :todo_list do
    association :todo_set
    association :creator, factory: :user
    title { Faker::Book.title }
    description { Faker::Lorem.paragraph }
  end
end
