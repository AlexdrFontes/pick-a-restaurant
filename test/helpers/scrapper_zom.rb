require 'open-uri'
require 'nokogiri'
require 'mechanize'
require 'byebug'
require 'json'

FILE_PATH = "catalogue.json"

def get_place_name(agent)
  return agent.search(".ui.large.header.left").text.to_s.lstrip.rstrip
end

def get_place_address(agent)
  main_address = agent.search(".borderless.res-main-address")
  return main_address.search('span').first.text.to_s
end

def get_place_locality(agent)
  return agent.search(".left.grey-text.fontsize3").text.to_s.lstrip.rstrip
end

def get_place_average_cost_for_two(agent)
  main_cost = agent.search(".res-info-detail")
  #Para restaurantes que têm vários preços (jantar, almoço), tiramos só o de jantar
  a = main_cost.search('span')[2].text.to_s.lstrip.rstrip
  array = a.split('.')
  #Bug do zomato no restaurante Pizzeria Romana Al Taglio, Baixa(não tem info icon)
  if array.empty?
    a = "15"
  else
    a = array[0].gsub(/\D/,'')
  end

  return a
end

def get_place_featured_image(agent)
  a = agent.search("#progressive_image")
  return a.attr("data-url").value
end

def get_place_users_rating(agent)
  return agent.search(".rating-div.rrw-aggregate").text.to_s.lstrip.rstrip.gsub(/\/5$/,'').to_f
end

def get_place_phone_number(agent)
  if agent.search(".fontsize2.bold.zgreen").empty?
    a = 0
  else
    a = agent.search(".fontsize2.bold.zgreen").first.text.to_s.strip.delete(' ').to_i
  end
  return a
end

def get_place_schedule(agent)
  a = agent.search(".medium").first.text.to_s.gsub(/[a-zA-Z]+|\s/,'')
  a = a.gsub("\u00A0", "")
  array = []
  array[0] = a.chars.first(5).join
  array[1] = a.chars.last(5).join
  return array
end

def get_cuisines(agent)
  a = agent.search(".res-info-cuisines.clearfix")
  array = []
  a.search(".zred").each do |type|
    array << type.text.to_s
  end
  return array
end

def get_type_of_meal(agent, schedule_array)
  more_info_array = []
  agent.search(".res-info-feature-text").each do |type|
    more_info_array << type.text.to_s
  end

  type_meal_array = []
  more_info_array = more_info_array.select {|i| i == 'Nightlife' || i == 'Brunch'}
  schedule_array_integer = []
  schedule_array_integer[0] = schedule_array[0].gsub(/\D/,'').to_i
  schedule_array_integer[1] = schedule_array[1].gsub(/\D/,'').to_i

  if schedule_array_integer[1] < 2000 || schedule_array_integer[0] < 1300
    more_info_array << "Lunch"
  end

  if schedule_array_integer[1] > 2100 || schedule_array_integer[1] < 400
    more_info_array << "Dinner"
  end

  return more_info_array
end

def get_place_lat_lng(agent)
 a = agent.search(".resmap.pos-relative.mt5.mb5")
 array = []
 array = a.search('script').text.to_s.lstrip.rstrip.split(',', 2)
 lat_lng_array = []
 array.each do |element|
  lat_lng_array << element.match(/[+-]?([0-9]*[.])?[0-9]+/).to_s
 end
 return lat_lng_array
end


# def get_menu_pics(agent)
#   a = agent.search(".js-swipebox").each do |link|
#   agent_inside = Mechanize.new
#   agent_inside.user_agent_alias = 'Mac Safari'
#   inside_page_link = link[:href]
# end

def get_place_photos(agent)
  urls_array = []
  a = agent.search(".item.respageMenu-item.photosTab").attr('href').value
  agent_inside = Mechanize.new
  agent_inside.user_agent_alias = 'Mac Safari'
  ## We enter the page for each link and save the data we want
  current_agent = agent_inside.get(a)
  current_agent.search(".photobox.pos-relative.left.mb10.js-heart-container.thumbContainer")[1..6].each do |link|

    a = link.search(".res-photo-thumbnail.thumb-load").attr('data-original').value.match(/(^.*)(?=\?)/).to_s
    urls_array << a
  end
  return urls_array
end


def save(data)
  File.open(FILE_PATH, "w+") do |f|
    f << data.to_json
  end
end


places = []

agent = Mechanize.new
agent.user_agent_alias = 'Mac Safari'

limit = 1 # page limit in url
for page_number in 1..limit
  zom_url = URI "https://www.zomato.com/grande-lisboa/best-dine-out-in-lisboa?ref_page=zone&page=#{page_number}"


  # Search each link inside a card

  agent.get(zom_url).search(".result-title.hover_feedback").each do |link|
    ######TODO 1: will click the link and scrape data inside that link
      agent_inside = Mechanize.new
      agent_inside.user_agent_alias = 'Mac Safari'
      inside_page_link = link[:href]
      ## We enter the page for each link and save the data we want
      current_agent = agent_inside.get(inside_page_link)
      schedule = get_place_schedule(current_agent)
      latitude_longitude_array = get_place_lat_lng(current_agent)

      place = {
        name: get_place_name(current_agent),
        address: get_place_address(current_agent),
        locality: get_place_locality(current_agent),
        average_cost_for_two: get_place_average_cost_for_two(current_agent),
        featured_image: get_place_featured_image(current_agent),
        user_rating: get_place_users_rating(current_agent),
        phone_number: get_place_phone_number(current_agent),
        cuisines: get_cuisines(current_agent),
        schedule: schedule,
        meal_types: get_type_of_meal(current_agent, schedule),
        latitude: latitude_longitude_array[0],
        longitude: latitude_longitude_array[1],
        photos: get_place_photos(current_agent)
      }
      places << place
  end
  save(places)
end
