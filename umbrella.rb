require "http"
require "json"

puts "Where are you?"
user_location = gets.chomp

gmaps_key = ENV.fetch("GMAPS_KEY")
gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{gmaps_key}"


gmaps_data = (HTTP.get(gmaps_url)).to_s
gmaps_parse = JSON.parse(gmaps_data)
parse_results_array = gmaps_parse.fetch("results")
first_result_hash = parse_results_array.at(0)
geometry_hash = first_result_hash.fetch("geometry")
location_hash = geometry_hash.fetch("location")
latitude = location_hash.fetch("lat")
longitude = location_hash.fetch("lng")

pirate_weather_key = ENV.fetch("PIRATE_WEATHER_KEY")
pirate_weather_url = "https://api.pirateweather.net/forecast/#{pirate_weather_key}/#{latitude},#{longitude}"

pirate_weather_data = (HTTP.get(pirate_weather_url)).to_s
parsed_pirate_data = JSON.parse(pirate_weather_data)
current_weather_hash = parsed_pirate_data.fetch("currently")
precip_prob = current_weather_hash.fetch("precipProbability")
weather_summary = current_weather_hash.fetch("summary")
temperature = current_weather_hash.fetch("temperature")

puts "=" * 40
puts "The current temperature is: #{temperature}, the current weather is: #{weather_summary}, and the probability of precipitation in the next hour is: #{precip_prob}%."
