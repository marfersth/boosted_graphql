# frozen_string_literal: true

module Types
  class GroupType < Types::BaseObject
    implements Types::RecordType
    description 'A group'

    field :name, String, null: false
  end
end
