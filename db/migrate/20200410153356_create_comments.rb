class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, null: false
      t.references :creator, null: false, foreign_key: { to_table: :users }, index: true

      t.timestamps
    end
  end
end
