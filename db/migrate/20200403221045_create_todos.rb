class CreateTodos < ActiveRecord::Migration[6.0]
  def change
    create_table :todos do |t|
      t.references :parent, null: false, foreign_key: { to_table: :todo_lists }
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.string :title, null: false
      t.integer :todos_count, null: false, default: 0
      t.integer :position, null: false, default: 0
      t.boolean :completed, null: false, default: false
      t.datetime :starts_on, index: true
      t.datetime :due_on, index: true

      t.timestamps
    end
  end
end
