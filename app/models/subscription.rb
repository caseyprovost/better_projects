class Subscription < ApplicationRecord
  belongs_to :recording
  has_many :subscribers, dependent: :delete_all

  validates :action, presence: true
end
