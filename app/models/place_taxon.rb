class PlaceTaxon < ApplicationRecord
  include RailsEvent::PlaceTaxon
  include RailsTaxon::Node
end unless defined? PlaceTaxon
