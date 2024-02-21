class Permission < ApplicationRecord
  belongs_to :permissionable, polymorphic: true
  belongs_to :group
end
