module Eventual
  module Model::PlaceTaxon
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :position, :integer
      attribute :profit_margin, :decimal, precision: 4, scale: 2
      attribute :places_count, :integer

      belongs_to :organ, optional: true
      has_many :places, dependent: :nullify

      acts_as_list
    end

  end
end
