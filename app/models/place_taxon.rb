class PlaceTaxon < ApplicationRecord
  include RailsEvent::PlaceTaxon
  include RailsCom::Taxon
end unless defined? PlaceTaxon
