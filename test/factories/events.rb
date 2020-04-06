FactoryBot.define do
  factory :event do
    recording { nil }
    creator { nil }
    action { "MyString" }
    details { "" }
  end
end
