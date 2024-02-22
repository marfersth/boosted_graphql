class PropertyQueryObject
  include Concerns::DefaultOrder

  attr_reader :filters, :properties

  def initialize(params, properties)
    params = eval(params)
    @filters = params[:q]
    @properties = properties.extending(Scopes)
    initialize_order(params)
  end

  def get
    filtered_properties = properties.filtered(filters)
    filtered_properties = order(filtered_properties) if order_by_param
    filtered_properties
  end

  private

  def order(collection)
    if order_by_param.include? 'properties.'
      property_key = order_by_param.split('properties.').second

      sorted_properties = collection.sort_by do |property|
        if property.key == property_key
          property.value
        else
          raise StandardError.new "to sort by property key: '#{property_key}' must filter records by property key equal to '#{property_key}'"
        end
      end

      if direction_param == 'asc'
        sorted_properties
      elsif direction_param == 'desc'
        sorted_properties.reverse
      end
    else
      ordered(collection)
    end
  end

  module Scopes
    def filtered(filters)
      search = ransack(filters)
      sql = search.result(distinct: true).to_sql.dup
      sql.scan(/"properties"."value"\s*=\s*'"(true|false|\d+)"'/).flatten.each do |string|
        number_or_boolean = string.gsub("\"","")
        sql.gsub!(/"properties"."value"\s*=\s*'"#{number_or_boolean}"'/, "\"properties\".\"value\" = '#{number_or_boolean}'")
      end
      query = <<-SQL
                #{sql}
              SQL
      Property.includes(:permissions)
             .select('*').from("(#{query}) AS property")
    end
  end
end
