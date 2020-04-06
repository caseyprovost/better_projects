module HasPosition
  extend ActiveSupport::Concern

  included do
    before_create :set_position
  end

  private

  def last_position_for_parent
    parent.positionable_children.order(position: :desc).limit(1)&.position || 0
  end

  def set_position
    self.position ||= last_position_for_parent
  end
end
