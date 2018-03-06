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
  return main_cost.search('span')[2].text.to_s.lstrip.rstrip.gsub(/\D/,'')
end

def get_place_featured_image(agent)
  a = agent.search("#progressive_image")
  return a.attr("data-url").value
end

def get_place_users_rating(agent)
  return agent.search(".rating-div.rrw-aggregate").text.to_s.lstrip.rstrip.gsub(/\/5$/,'').to_f
end

def get_place_phone_number(agent)
  return agent.search(".fontsize2.bold.zgreen").text.to_s.strip.delete(' ').to_i
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
  more_info_array = more_info_array.select {|i| i == 'Beber um copo' || i == 'Brunch'}
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


def save(data)
  File.open(FILE_PATH, "w+") do |f|
    f << data.to_json
  end
end


places = []

agent = Mechanize.new
agent.user_agent_alias = 'Mac Safari'

limit = 80 # page limit in url
for page_number in 1..limit
  zom_url = URI "https://www.zomato.com/pt/grande-lisboa/comer-fora-em-lisboa?ref_page=zone&page=#{page_number}"

  # Search each link inside a card
  agent.get(zom_url).search(".result-title.hover_feedback").each do |link|
    # puts link[:href]
    ######TODO 1: will click the link and scrape data inside that link
      agent_inside = Mechanize.new
      agent_inside.user_agent_alias = 'Mac Safari'
      inside_page_link = link[:href]
      ## We enter the page for each link and save the data we want
      current_agent = agent_inside.get(inside_page_link)
      schedule = get_place_schedule(current_agent)
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
        meal_types: get_type_of_meal(current_agent, schedule)
      }
      places << place

  end
  save(places)
end




