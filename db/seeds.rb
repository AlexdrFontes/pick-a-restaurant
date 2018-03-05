# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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


User.create(email: "indiana@gmail.com", password: 123456, first_name: "Indiana", last_name: "Franco")
User.create(email: "alex@gmail.com", password: 123456, first_name: "Alexandre", last_name: "Fontes")
User.create(email: "joana@gmail.com", password: 123456, first_name: "Joana", last_name: "Leão")
User.create(email: "francisco@gmail.com", password: 123456, first_name: "Francisco", last_name: "Bota")

a = Place.create(name: "Boa-Bao", address: "Largo Rafael Bordalo Pinheiro, 30, Chiado, Lisboa", city: "Lisboa", locality: "Chiado", average_cost_for_two: 40, featured_image: "https://b.zmtcdn.com/data/pictures/0/18487870/6f7c0e96f8d14a4f8acb655bf5d1e0f5.jpg?output-format=webp", user_rating: 4.7, phone_number: 308808367, schedule: "12:00-23:30", latitude: "38.7115650554", longitude: "-9.1415704787")
associate_cuisine(a, ["Oriental", "Thai", "Malaysian", "Filipino", "Vietnamese", "Korean", "Japanese", "Chinese"])
associate_meal(a, ["Dinner", "Lunch"])

b = Place.create(name: "Nicolau Lisboa", address: "Rua de São Nicolau, 17, Baixa, Lisboa", city: "Lisboa", locality: "Baixa", average_cost_for_two: 15, featured_image: "https://b.zmtcdn.com/data/res_imagery/18364579_RESTAURANT_fab5dc973cc0448bb125addd8c4a5cd3.jpg", user_rating: 4.3, phone_number: 218860312, schedule: "09:00-21:00", latitude: "38.7105489263", longitude: "-9.1362305358")
associate_cuisine(b, ["Desserts", "Juices", "Healthy Food", "Finger Food"])
associate_meal(b,["Brunch", "Drinks"])

c = Place.create(name: "El Clandestino", address: "Rua da Rosa, 321, Príncipe Real, Lisboa", city: "Lisboa", locality: "Príncipe Real", average_cost_for_two: 40, featured_image: "https://b.zmtcdn.com/data/res_imagery/8214425_RESTAURANT_07995432fe2ad06660236f9178855116.jpg", user_rating: 4.2, phone_number: 915035553, schedule: "18:30-02:00", latitude: "38.7155080436", longitude: "-9.1462445632")
associate_cuisine(c, ["Peruvian", "Mexican"])
associate_meal(c, ["Lunch", "Dinner"])

d = Place.create(name: "The B Temple", address: "Rua Serpa Pinto, 10C, Chiado, Lisboa", city: "Lisboa", locality: "Chiado", average_cost_for_two: 30, featured_image: "https://b.zmtcdn.com/data/res_imagery/18401933_RESTAURANT_5dc59812a045927af918344b794776e3.jpg", user_rating: 4.6, phone_number: 214079398, schedule: "12:00-00:00", latitude: "38.7101740223", longitude: "-9.1415158287")
associate_cuisine(d, ["Burger", "Finger Food"])
associate_meal(d, ["Brunch", "Dinner"])

e = Place.create(name: "Heim Cafe", address: "Rua de Santos-O-Velho, 2/4, Santos, Lisboa 1200-812", city: "Lisboa", locality: "Santos", average_cost_for_two: 20, featured_image: "https://b.zmtcdn.com/data/pictures/chains/7/18446907/414bae238c834a68ddc5a3617e063740.jpg", user_rating: 4.6, phone_number: 212480763, schedule: "09:00-18:00", latitude: "38.7074091428", longitude: "-9.1564198583")
associate_cuisine(e, ["Coffee and Tea", "Cafe", "Healthy Food"])
associate_meal(e, ["Brunch", "Lunch"])

f = Place.create(name: "Maria Azeitona",
  address: "Rua Alfredo Keil, 16, Venteira, Amadora",
  city: "Lisboa",
  locality: "Venteira",
  average_cost_for_two: 25,
  featured_image: "https://b.zmtcdn.com/data/reviews_photos/23b/4b61cfef9e2cda83e7e193d4c1e7223b_1491063050.jpg?output-format=webp",
  user_rating: 4.6,
  phone_number: 214066261,
  schedule: "12:00 to 16:00",
  latitude: "38.7575713510",
  longitude:"-9.2351557687")
  associate_cuisine(f, ["Portuguese", "Petiscos"])
  associate_meal(f, ["Dinner", "Lunch"])

g = Place.create(name: "Popolo - Pizza & Burger",
  address: "Avenida 24 de Julho, 50, Santos, Lisboa",
  city: "Lisboa",
  locality: "Santos",
  average_cost_for_two: 25,
  featured_image: "https://b.zmtcdn.com/data/res_imagery/8212800_RESTAURANT_cc23bbe1366a78e93817909414e92776.jpg",
  user_rating: 3.7,
  phone_number: 916733156,
  schedule: "19:30 to 24:00",
  latitude: "38.7067092722",
  longitude:"-9.1527988762")
  associate_cuisine(g, ["Burger", "Pizza", "Beverages"])
  associate_meal(g, ["Dinner", "Lunch", "Brunch"])

h = Place.create(name: "O Quintal",
  address: "Rua Bernardim Ribeiro, 5B, Venteira, Amadora 2700-111 A",
  city: "Lisboa",
  locality: "Venteira",
  average_cost_for_two: 38,
  featured_image: "https://b.zmtcdn.com/data/pictures/chains/0/18425560/393cac3355b264af4def6b74e0433102.jpg",
  user_rating: 4.5,
  phone_number: 308801358 ,
  schedule: "19:30 to 23:00",
  latitude: "38.7578630000",
  longitude:"-9.2371660000")
  associate_cuisine(h, ["Petiscos", "Portuguese", "Mediterranean"])
  associate_meal(h, ["Lunch"])

i = Place.create(name: "Volver de Carne Y Alma",
  address: "Rua Luís de Freitas Branco, 5D, Lumiar, Lisboa 1600 488",
  city: "Lisboa",
  locality: "Lumiar",
  average_cost_for_two: 80,
  featured_image: "https://b.zmtcdn.com/data/pictures/chains/9/8204019/89a3e0b37869e2e9b737a65dcf9c62a3.jpg",
  user_rating: 4.9,
  phone_number: 308809312 ,
  schedule: "19:30 to 00:30",
  latitude: "38.7701864533",
  longitude:"-9.1608465090")
  associate_cuisine(i, ["Argentine", "Grill", "Steak"])
  associate_meal(i, ["Dinner"])

j = Place.create(name: "Butchers",
  address: "Rua do Pólo Sul, 15C, Parque das Nações, Lisboa 1990-092",
  city: "Lisboa",
  locality: "Parque das Nações",
  average_cost_for_two: 40,
  featured_image: "https://b.zmtcdn.com/data/pictures/chains/5/18275215/beddbca2203fff03fd51b8f888885796.jpg?output-format=webp",
  user_rating: 4.4,
  phone_number: 308804718 ,
  schedule: "12:00 to 15:00",
  latitude: "38.7652253804",
  longitude:"-9.0974280238")
  associate_cuisine(j, ["Steak", "Burger", "Grill"])
  associate_meal(j, ["Drinks"])
