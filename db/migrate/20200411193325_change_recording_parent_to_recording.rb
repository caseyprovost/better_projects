class ChangeRecordingParentToRecording < ActiveRecord::Migration[6.0]
  def change
    remove_column :recordings, :parent_type
    remove_column :recordings, :parent_id
    add_reference :recordings, :parent, foreign_key: { to_table: :recordings }, null: true
  end
end
