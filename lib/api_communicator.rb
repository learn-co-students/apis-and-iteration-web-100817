require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  movie_info = []
  new_hash = {}
  array = []
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  character_hash["results"].map do |item|
    if item["name"] == character
      movie_info << item["films"]
    end
  end

  movie_info.each do |url_array|
    url_array.each do |url|
      web_address = RestClient.get(url)
      new_hash = JSON.parse(web_address)
      array << new_hash

    end


  # binding.pry

  end
  array
end

def parse_character_movies(films_hash)
  films_hash.each.with_index do |movie, index|

    puts "Title: #{movie["title"]}"
    puts "Episode ID: #{movie["episode_id"]}"
    puts "Director: #{movie["director"]}"
    puts "Producer: #{movie["producer"]}"
    puts "Release Date: #{movie["release_date"]}"
    puts ""
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
