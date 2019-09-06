class EventItem < ApplicationRecord
  include RailsEvent::EventItem
end unless defined? EventItem
