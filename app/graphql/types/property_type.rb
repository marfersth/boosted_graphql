# frozen_string_literal: true

module Types
  class PropertyType < Types::BaseObject
    implements Types::RecordType
    description 'A subject property'

    field :key, String, null: false
    field :value, GraphQL::Types::JSON, null: false
    field :subject, Types::SubjectType

    def self.authorized?(object, context)
      super && object.permissions.find do |permission|
        permission.group_id == context[:current_group_id]
      end.present?
    end
  end
end
