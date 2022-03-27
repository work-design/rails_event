module Eventual
  module Ext::Planned
    extend ActiveSupport::Concern

    included do
      has_many :plans, class_name: 'Eventual::Plan', as: :planned, dependent: :delete_all
      has_many :plan_items, class_name: 'Eventual::PlanItem', as: :planned, dependent: :delete_all
    end

  end
end
