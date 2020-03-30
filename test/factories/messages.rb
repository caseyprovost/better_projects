FactoryBot.define do
  factory :message do
    association :message_board
    association :creator, factory: :user
    subject { Faker::Lorem.words(number: 4).join(" ") }
    content { Faker::Lorem.paragraph }
  end
end
