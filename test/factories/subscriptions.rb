FactoryBot.define do
  factory :subscription do
    recording
    user
    event { "todo.completed" }
  end
end
