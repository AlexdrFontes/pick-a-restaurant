class Place < ApplicationRecord
  has_many :places_histories
  has_many :place_cuisine_types
  has_many :place_meal_types
  has_many :cuisine_types, through: :place_cuisine_types
  has_many :meal_types, through: :place_meal_types
  has_many :photos
  has_many :users, through: :places_histories
  geocoded_by :address

end
