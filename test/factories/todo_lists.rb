FactoryBot.define do
  factory :todo_list do
    association :parent, factory: :todo_set
    association :creator, factory: :user
    title { "MyString" }
    todos_count { 0 }
    description { "MyString" }
    position { 0 }
  end
end
