class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.references :recording, null: false, foreign_key: true, index: true
      t.references :creator, null: true, foreign_key: { to_table: :users }, index: true
      t.string :action, null: false, index: true
      t.json :details, null: false, default: "{}"

      t.timestamps
    end
  end
end
