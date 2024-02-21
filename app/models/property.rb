class Property < ApplicationRecord
  has_many :permissions, foreign_key: 'permissionable_id', class_name: 'Permission', dependent: :destroy
  belongs_to :subject
end
