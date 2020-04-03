class CreateTodoLists < ActiveRecord::Migration[6.0]
  def change
    create_table :todo_lists do |t|
      t.references :parent, null: false, foreign_key: { to_table: :todo_sets }
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.string :title, null: false
      t.integer :todos_count, null: false, default: 0
      t.integer :position, null: false, default: 0
      t.index [:position, :parent_id], unique: true

      t.timestamps
    end
  end
end
