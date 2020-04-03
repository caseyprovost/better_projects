FactoryBot.define do
  factory :todo_set do
    bucket
    association :creator, factory: :user
    title { "MyString" }
    todo_list_count { 0 }
  end
end
