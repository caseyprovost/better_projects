FactoryBot.define do
  factory :todo do
    parent { nil }
    creator { nil }
    title { "MyString" }
    status { "MyString" }
    todos_count { 1 }
    description { "MyString" }
    position { 1 }
    completed { false }
    starts_on { "2020-04-03 18:10:45" }
    due_on { "2020-04-03 18:10:45" }
  end
end
