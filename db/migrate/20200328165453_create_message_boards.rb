class CreateMessageBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :message_boards do |t|
      t.references :project, null: false, foreign_key: true, index: { unique: true }

      t.timestamps
    end
  end
end
