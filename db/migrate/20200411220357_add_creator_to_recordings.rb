class AddCreatorToRecordings < ActiveRecord::Migration[6.0]
  def change
    add_reference :recordings, :creator, null: true, foreign_key: { to_table: :users }
  end
end
