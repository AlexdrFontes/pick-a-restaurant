class MealType < ApplicationRecord
  has_many :places, through: :place_meal_types
end
