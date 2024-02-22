class CreateSubject < ActiveRecord::Migration[6.1]
  def change
    create_table :subjects do |t|
      t.jsonb :data, default: {}
      t.string :update_type, null: false
      t.references :business_company, null: false
      t.timestamps
    end
  end
end
