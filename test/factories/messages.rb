FactoryBot.define do
  factory :message do
    message_board { nil }
    creator { nil }
    subject { "MyText" }
    content { "MyText" }
  end
end
