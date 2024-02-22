# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :subjects, [Types::SubjectType], preload_association: "subject" do
      argument :params, String, required: false
      argument :first, Integer, required: false
    end

    field :permission, [Types::PermissionType], null: false, description: "Return a list of permissions"
    field :properties, [Types::PropertyType, null: true]

    def subjects(params: nil, first: nil)
      scope = Subject.includes(:permissions, properties: [:permissions])
      subjects = first ? scope.limit(first) : scope.all
      if params
        SubjectQueryObject.new(params, subjects).get
      else
        subjects
      end
    end

    def permissions
      Permission.all
    end

    def properties
      Property.includes(:permissions).all
    end
  end
end
