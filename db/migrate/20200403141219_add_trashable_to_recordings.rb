class AddTrashableToRecordings < ActiveRecord::Migration[6.0]
  def change
    add_reference :recordings, :trashed_by, null: true, foreign_key: {to_table: :users}, index: true
    add_column :recordings, :trashed_at, :datetime
  end
end
