# frozen_string_literal: true

module Types
  class PermissionType < Types::BaseObject
    implements Types::RecordType
    description 'A permission'

    field :permissionable_type, String, null: false
    field :permissionable_id, ID, null: false
    field :group_id, ID, null: false
  end
end
