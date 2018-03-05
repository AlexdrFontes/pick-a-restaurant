class PlaceCuisineType < ApplicationRecord
  belongs_to :cuisine_type
  belongs_to :place
end
