class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.references :account, null: false, foreign_key: true, index: true
      t.string :name, null: false
      t.string :status, null: false, default: "active"
      t.text :description, null: false

      t.timestamps
    end
  end
end
