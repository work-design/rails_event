class EventTaxon < ApplicationRecord
  include RailsEvent::EventTaxon
end unless defined? EventTaxon
