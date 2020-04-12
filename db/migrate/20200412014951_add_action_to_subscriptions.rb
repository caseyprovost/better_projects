class AddActionToSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :action, :string, null: false
  end
end
