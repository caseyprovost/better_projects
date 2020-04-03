class CreateTodoSets < ActiveRecord::Migration[6.0]
  def change
    create_table :todo_sets do |t|
      t.references :bucket, null: false, foreign_key: true
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.string :title, null: false
      t.integer :todo_list_count, null: false, default: 0

      t.timestamps
    end
  end
end
