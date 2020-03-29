class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :message_board, null: false, foreign_key: true, index: true
      t.references :creator, null: false, foreign_key: {to_table: :users}, index: true
      t.text :subject, null: false, default: ""
      t.text :content, null: false, default: ""

      t.timestamps
    end
  end
end
