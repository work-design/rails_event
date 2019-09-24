module RailsEvent::PlanParticipant::NormalParticipant
  extend ActiveSupport::Concern
  included do
  end

  class_methods do
  
    def participant_types
      return @participant_types if defined? @participant_types
      @participant_types = {}
      self.distinct.pluck(:participant_type).each do |participant_type|
        @participant_types[participant_type.tableize.to_sym] = participant_type
      end
      @participant_types
    end

  end
  
end
