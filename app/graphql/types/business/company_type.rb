# frozen_string_literal: true

module Types
  class Business::CompanyType < Types::BaseObject
    implements Types::RecordType
    description 'A company'

    field :name, String, null: false
    field :group, Types::GroupType, null: true
  end
end
