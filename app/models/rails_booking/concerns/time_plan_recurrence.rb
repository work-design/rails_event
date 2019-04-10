module TimePlanRecurrence
  extend ActiveSupport::Concern

  included do
    attribute :repeat_type, :string, default: ''
    if defined?(ActiveRecord::ConnectionAdapters::PostgreSQLAdapter) && connection.is_a?(ActiveRecord::ConnectionAdapters::PostgreSQLAdapter)
      attribute :repeat_days, :json, default: {}
    else
      serialize :repeat_days, Hash
    end

    enum repeat_type: {
      once: 'once',
      weekly: 'weekly',
      monthly: 'monthly'
    }
  end



end
