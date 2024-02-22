module Types
  class PreloadAssociationsExtension < GraphQL::Schema::FieldExtension
    def resolve(object:, arguments:, **more_arguments)
      preloadable_associations_hash = preloadable_associations(arguments[:lookahead], arguments[:association_name])
      arguments = arguments.except(:lookahead, :association_name)
      yield(object, arguments, preloadable_associations_hash)
    end

    def after_resolve(value:, memo:, **rest)
      return if value.blank?

      preloadable_associations_hash = memo
      ActiveRecord::Associations::Preloader.new.preload(value_records(value), preloadable_associations_hash)
      value
    end

    def value_records(value)
      return value if value.respond_to?(:each)

      return value.items if value.respond_to?(:items)

      [value]
    end

    def preloadable_associations(lookahead, model_name)
      to_preloadable_associations_hash(
        selections_from_query_pattern(lookahead), model_name
      ).values.first
    end

    def to_preloadable_associations_hash(lookahead, node_association_name)
      associations_to_preload = { node_association_name => {} }
      selections = lookahead.respond_to?(:each) ? lookahead : lookahead.selections

      selections.each do |selection|
        next if selection.selections.blank?

        associations = associated_entities_for(node_association_name)
        next if associations.blank?

        next unless associations.include? selection.name

        associations_to_preload[node_association_name].merge!(
          to_preloadable_associations_hash(selection, selection.name)
        )
      end

      associations_to_preload
    end

    def selections_from_query_pattern(lookahead)
      case query_pattern(lookahead)
      when :edges_available
        flatten_without_edges(lookahead)
      when :can_proceed
        lookahead
      end
    end

    def query_pattern(lookahead)
      return :edges_available if lookahead.selects?(:edges)

      :can_proceed
    end

    def flatten_without_edges(lookahead)
      lookahead.selections.map do |selection|
        selection.selects?(:node) ? selection.selection(:node).selections : selection
      end.flatten
    end

    def associated_entities_for(model_name)
      model_namespaced = model_name.to_s
                                   .gsub('business_', 'business/')
      association_class = model_namespaced.singularize.classify.safe_constantize
      return [] unless association_class&.respond_to?(:reflect_on_all_associations)

      association_class.reflect_on_all_associations.map(&:name)
    end
  end
end
