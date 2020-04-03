class CreateRecordings < ActiveRecord::Migration[6.0]
  def change
    create_table :recordings do |t|
      t.references :recordable, polymorphic: true, null: false
      t.references :bucket, null: false, foreign_key: true, index: true
      t.references :parent, polymorphic: true, null: false
      t.string :status, null: false, default: "active"
      t.string :title, null: false

      t.timestamps
    end
  end
end
