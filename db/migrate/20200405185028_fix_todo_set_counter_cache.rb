class FixTodoSetCounterCache < ActiveRecord::Migration[6.0]
  def change
    add_column :todo_sets, :todo_lists_count, :integer, null: false, default: 0
    remove_column :todo_sets, :todo_list_count, :integer, null: false, default: 0
  end
end
