FactoryBot.define do
  factory :comment do
    association :commentable, factory: :recording
    association :creator, factory: :user
  end
end
