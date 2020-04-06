class Event < ApplicationRecord
  belongs_to :recording
  belongs_to :creator, optional: true, default: -> { User.current }
end
