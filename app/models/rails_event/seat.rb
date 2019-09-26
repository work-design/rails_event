module RailsEvent::Seat
  extend ActiveSupport::Concern
  
  included do
    attribute :name, :string

    belongs_to :place
    has_many :plans
    
    validates :name, presence: true
  end

end
