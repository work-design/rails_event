module Eventual
  class PlaceTaxon < ApplicationRecord
    include Model::PlaceTaxon
    include Com::Ext::Taxon
  end
end
