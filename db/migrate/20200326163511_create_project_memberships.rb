class CreateProjectMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :project_memberships do |t|
      t.references :project, null: false, foreign_key: true, index: true
      t.references :user, null: false, foreign_key: true, index: true
      t.string :permission, null: false, default: "read"
      t.string :status, null: false, default: "active"

      t.timestamps
      t.index [:project_id, :user_id], unique: true
    end
  end
end
