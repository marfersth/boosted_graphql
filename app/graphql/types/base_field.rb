# frozen_string_literal: true

module Types
  class BaseField < GraphQL::Schema::Field
    argument_class Types::BaseArgument

    def initialize(*args, preload_association: nil, **kwargs, &block)
      if preload_association.present?
        @association_name = preload_association
        kwargs[:extras] = kwargs.fetch(:extras, []) + %i[association_name lookahead]
      end

      super(*args, **kwargs, &block)

      return if @association_name.blank?

      extension(Types::PreloadAssociationsExtension)
    end

    attr_reader :association_name
  end
end
