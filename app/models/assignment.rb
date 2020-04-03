class Assignment < ApplicationRecord
  belongs_to :assignable, polymorphic: true
  belongs_to :user
end
