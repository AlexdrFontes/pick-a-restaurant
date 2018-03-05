class CuisineType < ApplicationRecord
  has_many :places, through: :place_cuisine_types
end
