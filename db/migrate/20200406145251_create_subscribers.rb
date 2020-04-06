class CreateSubscribers < ActiveRecord::Migration[6.0]
  def change
    create_table :subscribers do |t|
      t.references :subscription, null: false, foreign_key: true, index: true
      t.references :user, null: false, foreign_key: true, index: true
      t.index [:subscription_id, :user_id], unique: true

      t.timestamps
    end
  end
end
