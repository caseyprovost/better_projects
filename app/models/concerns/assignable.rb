module Assignable
  extend ActiveSupport::Concern

  included do
    attribute :assignee_ids

    has_many :assignments, as: :assignable, autosave: true
    has_many :assignees, through: :assignments

    after_save :change_assignees
  end

  def change_assignees
    if assignee_ids.present?
      assignee_ids.each do |user_id|
        next assignments.where(user_id: user_id).exists?
        Assignment.create!(assignable_type: self.class.name, assignable_id: id, user_id: user_id)
      end
    elsif !assignee_ids.nil? && assignee_ids.empty?
      assignments.destroy_all
    else
      # do nothing if not intentionally modifying assignees
    end
  end
end
