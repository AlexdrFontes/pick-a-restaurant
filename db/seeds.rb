# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
require 'json'

User.destroy_all
Photo.destroy_all
Place.destroy_all

PlaceCuisineType.destroy_all
PlaceMealType.destroy_all
CuisineType.destroy_all
MealType.destroy_all

def associate_cuisine(place, cuisine_types)
  cuisine_types.each do |cuisine|
    c = CuisineType.find_or_create_by(name: cuisine)
    place.place_cuisine_types.create(cuisine_type: c)
  end
end

def associate_meal(place, meal_types)
  meal_types.each do |meal|
   c = MealType.find_or_create_by(name: meal)
    place.place_meal_types.create(meal_type: c)
  end
end

def associate_photos(place, photos)
  photos.each do |photo|
    # m = Photo.create(url: photo)
    place.photos.create(place: place, url:photo)
  end
end

User.create(email: "indiana@gmail.com", password: 123456, first_name: "Indiana", last_name: "Franco")
User.create(email: "alex@gmail.com", password: 123456, first_name: "Alexandre", last_name: "Fontes")
User.create(email: "joana@gmail.com", password: 123456, first_name: "Joana", last_name: "Leão")
User.create(email: "francisco@gmail.com", password: 123456, first_name: "Francisco", last_name: "Bota")

file = File.read "catalogue.json"
data = JSON.parse(file)
data.each do |element|
    schedule = element['schedule']
    a = Place.create(
        name: element['name'],
        address: element['address'],
        city: "Lisboa",
        locality: element['locality'],
        average_cost_for_two: element['average_cost_for_two'],
        featured_image: element['featured_image'],
        user_rating: element['user_rating'],
        latitude: element['latitude'],
        longitude: element['longitude'],
        opening_time: schedule[0],
        closing_time: schedule[1],
        phone_number: element['phone_number'])
    associate_cuisine(a, element['cuisines'])
    associate_meal(a, element['meal_types'])
    associate_photos(a, element['photos'])
end

