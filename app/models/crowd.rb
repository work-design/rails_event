class Crowd < ApplicationRecord
  include RailsEvent::Crowd
end unless defined? Crowd
