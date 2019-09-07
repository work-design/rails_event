module RailsEvent::Member
  extend ActiveSupport::Concern
  
  included do
    has_many :event_participants, as: :member, dependent: :destroy
    has_many :events, through: :event_participants

    has_many :crowd_members, as: :member, dependent: :destroy
    has_many :crowds, through: :crowd_members

    has_many :plan_members, as: :member, dependent: :destroy
    has_many :plan_attenders, as: :attender, dependent: :destroy
  end

  
end
