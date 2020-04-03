class AddArchivableToRecordings < ActiveRecord::Migration[6.0]
  def change
    add_reference :recordings, :archived_by, null: true, foreign_key: {to_table: :users}, index: true
    add_column :recordings, :archived_at, :datetime
  end
end
