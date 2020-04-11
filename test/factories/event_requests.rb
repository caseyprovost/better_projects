FactoryBot.define do
  factory :event_request do
    event { nil }
    guid { "MyString" }
    user_agent { "MyString" }
    ip_address { "MyString" }
  end
end
