class PlaceTaxon < ApplicationRecord
  include RailsEvent::PlaceTaxon
  prepend RailsTaxon::Node
end unless defined? PlaceTaxon
