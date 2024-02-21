class CreateBusinessCompany < ActiveRecord::Migration[6.1]
  def change
    create_table :business_companies do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
