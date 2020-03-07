module RailsEvent::Seat
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :min_members, :integer, default: 1
    attribute :max_members, :integer

    belongs_to :place, counter_cache: true
    has_many :plans

    validates :name, presence: true
  end

end
