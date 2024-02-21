module Concerns::DefaultOrder
  extend ActiveSupport::Concern

  DIRECTION_VALUES = %w[desc asc].freeze
  DEFAULT_ORDER_DIRECTION = 'asc'.freeze
  DEFAULT_ORDER_BY = 'created_at'.freeze

  included do
    attr_reader :order_by_param, :direction_param
  end

  def initialize_order(params)
    @order_by_param = params[:order_by]
    @direction_param = params[:direction]
  end

  def order_by
    order_by_param || DEFAULT_ORDER_BY
  end

  def direction
    DIRECTION_VALUES.include?(direction_param) ? direction_param : DEFAULT_ORDER_DIRECTION
  end

  def ordered(collection, order_param = nil)
    order = order_param.present? ? "#{order_param}," : nil
    collection.order("#{order} #{order_by} #{direction} NULLS LAST".lstrip)
  end
end
