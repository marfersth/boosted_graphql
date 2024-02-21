class SubjectQueryObject
  include Concerns::DefaultOrder

  attr_reader :filters, :subjects

  def initialize(params, subjects)
    params = eval(params)
    @filters = params[:q]
    @subjects = subjects.extending(Scopes)
    initialize_order(params)
  end

  def get
    filtered_subjects = subjects.filtered(filters)
    filtered_subjects = order(filtered_subjects) if order_by_param
    filtered_subjects
    # filtered_subjects = subjects.filtered(filters)
    # filtered_subjects.order("#{order_by} #{direction}")
  end

  private

  def order(collection)
    if order_by_param.include? 'properties.'
      property_key = order_by_param.split('properties.').second

      # properties = Property.where(subject_id: collection.map(&:id), key: property_key)
      # value = properties.where.not(value: nil).first.value
      # aa = if value.is_a? Numeric
      #        -Float::INFINITY
      #      elsif value.is_a? String
      #        begin
      #          Date.parse(value)
      #          Date.new(0).to_s
      #        rescue
      #          "zzzzzzzzzzz"
      #        end
      #      elsif value.in? [true, false]
      #        false
      #      end

      sorted_subjects = collection.sort_by do |subject|
        property = subject.properties.find{ |property| property.key == property_key }
        if property
          property.value
        else
          raise StandardError.new "to sort by property key: '#{property_key}' must filter records by property key equal to '#{property_key}'"
        end

        # # Float::INFINITY is to set the NULL values at the end of the collection
        # if direction_param == 'asc'
        #   # subject.properties.find{ |property| property.key == property_key }.try(:value).try(:to_f) || Float::INFINITY
        #   subject.properties.find{ |property| property.key == property_key }.try(:value)
        # elsif direction_param == 'desc'
        #   # -(subject.properties.find{ |property| property.key == property_key }.try(:value).try(:to_f) || -Float::INFINITY)
        #   -subject.properties.find{ |property| property.key == property_key }.try(:value)
        # end
      end
      if direction_param == 'asc'
        sorted_subjects
      elsif direction_param == 'desc'
        sorted_subjects.reverse
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
      Subject.includes(:permissions, properties: [:permissions])
             .select('*').from("(#{query}) AS subjects")
    end
  end
end
