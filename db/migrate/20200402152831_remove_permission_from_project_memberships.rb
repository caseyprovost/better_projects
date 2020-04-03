class RemovePermissionFromProjectMemberships < ActiveRecord::Migration[6.0]
  def change
    remove_column :project_memberships, :permission, :string, null: false, default: ""
  end
end
