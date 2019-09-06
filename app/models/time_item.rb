class TimeItem < ApplicationRecord
  include RailsEvent::TimeItem
end unless defined? TimeItem
