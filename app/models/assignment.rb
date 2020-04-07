class Assignment < ApplicationRecord
  belongs_to :assignable, polymorphic: true
  belongs_to :assignee, class_name: "User", foreign_key: :user_id
end