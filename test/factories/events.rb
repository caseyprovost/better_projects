FactoryBot.define do
  factory :event do
    bucket
    recording
    association :creator, factory: :user
    association :recordable, factory: :comment
    action { "created" }
    details { "{}" }
  end
end
