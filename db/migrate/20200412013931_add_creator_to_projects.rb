class AddCreatorToProjects < ActiveRecord::Migration[6.0]
  def change
    add_reference :projects, :creator, null: false, foreign_key: {to_table: :users}, null: false
  end
end
