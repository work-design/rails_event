module Eventual
  module Model::Planned
    extend ActiveSupport::Concern

    included do
      has_many :plans, as: :planned, dependent: :delete_all
      has_many :plan_items, as: :planned, dependent: :delete_all
    end

  end
end
