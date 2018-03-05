class PlaceMealType < ApplicationRecord
  belongs_to :place
  belongs_to :meal_type
end
