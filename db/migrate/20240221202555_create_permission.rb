class CreatePermission < ActiveRecord::Migration[6.1]
  def change
    create_table :permissions do |t|
      t.references :permissionable, polymorphic: true, null: false
      t.references :group, null: false
      t.timestamps
    end
  end
end
