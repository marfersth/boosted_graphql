# frozen_string_literal: true

module Types
  class SubjectType < Types::BaseObject
    implements Types::RecordType
    description 'A subject'

    field :data, GraphQL::Types::JSON
    field :business_company, Types::Business::CompanyType, description: "The subject company"
    field :update_type, String, null: false
    field :properties, [Types::PropertyType, null: true], description: "This are subject properties" do
      argument :params, String, required: false
      argument :first, Integer, required: false
    end
    field :permissions, [Types::PermissionType], description: "This are subject permissions"

    def self.authorized?(object, context)
      super && object.permissions.find do |permission|
        permission.group_id == context[:current_group_id]
      end.present?
    end

    def properties(params: nil, first: nil)
      scope = self.object.properties
      properties = first ? scope.limit(first) : scope
      if params
        PropertyQueryObject.new(params, properties).get
      else
        properties
      end
    end
  end
end
