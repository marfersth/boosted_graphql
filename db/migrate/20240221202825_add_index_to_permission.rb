class AddIndexToPermission < ActiveRecord::Migration[6.1]
  def change
    add_index :permissions, :permissionable_id
  end
end
