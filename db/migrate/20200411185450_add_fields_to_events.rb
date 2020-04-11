class AddFieldsToEvents < ActiveRecord::Migration[6.0]
  def change
    add_reference :events, :recordable, polymorphic: true, null: false
    add_reference :events, :recordable_previous, polymorphic: true, null: false, index: false
    add_reference :events, :bucket, null: false, foreign_key: true
    add_index :events, [:recordable_previous_type, :recordable_previous_id], unique: false, name: "recordable_previous_index"
  end
end
