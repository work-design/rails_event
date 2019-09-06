class Place < ApplicationRecord
  include RailsEvent::Place
end unless defined? Place
