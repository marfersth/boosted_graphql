class CreateProperty < ActiveRecord::Migration[6.1]
  def change
    create_table :properties do |t|
      t.string :key, null: false
      t.jsonb :value, default: {}, null: false
      t.references :subject, foreign_key: true, null: false
      t.timestamps
    end
  end
end
