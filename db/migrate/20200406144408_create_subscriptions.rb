class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.references :recording, foreign_key: true, null: false
      t.string :action, null: false, index: true

      t.timestamps
    end
  end
end
