class Subject < ApplicationRecord
  has_many :properties
  has_many :permissions, foreign_key: 'permissionable_id', class_name: 'Permission'
  belongs_to :business_company, class_name: 'Business::Company', foreign_key: 'business_company_id'
end
