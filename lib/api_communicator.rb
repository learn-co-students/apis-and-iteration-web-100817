require 'rest-client'
require 'json'
require 'pry'

def all_fetch_starwars_characters
  all_characters = []
  i = 1
  begin
    page_characters = RestClient.get("http://www.swapi.co/api/people/?page=#{i}")
    page_characters_parsed = JSON.parse(page_characters)
    all_characters << page_characters_parsed["results"]
    i += 1
  end while  page_characters_parsed["next"] != nil
  all_characters.flatten
end


# def get_character_movies_from_api(character)
#   #make the web request
#   character_hash = all_fetch_starwars_characters
#   character_films = []
#
#   character_hash.each do |person_data|
#     if person_data["name"] == character
#       character_films = person_data["films"]
#     end
#   end
#   character_films
# end

# def get_character_movies_from_api(character)
#   #make the web request
#   character_hash = all_fetch_starwars_characters
#
#   character_data = character_hash.map do |person_data|
#     if person_data["name"] == character
#       person_data["films"]
#     end
#   end
#   character_data.compact
# end

def get_character_movies_from_api(character)
  #make the web request
  character_hash = all_fetch_starwars_characters

  character_data = character_hash.find { |data| data["name"] == character }
  film_urls = character_data["films"]
  film_data = film_urls.collect { |data| JSON.parse(RestClient.get(data)) }
  film_data
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each {|data| puts data["title"]}
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end
