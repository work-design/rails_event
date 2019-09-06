class TimeList < ApplicationRecord
  include RailsEvent::TimeList
end unless defined? TimeList
