class CreateAccountMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :account_members do |t|
      t.references :account, null: false, foreign_key: true, index: true
      t.references :user, null: false, foreign_key: true, index: true
      t.references :role, null: false, foreign_key: {to_table: :account_roles}
      t.timestamps
      t.index [:user_id, :account_id], unique: true
    end
  end
end
