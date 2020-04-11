class RemoveActionFromSubscriptions < ActiveRecord::Migration[6.0]
  def change
    remove_column :subscriptions, :action, :string, required: true, null: false
  end
end
