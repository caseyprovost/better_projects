module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, through: :recording
  end
end
