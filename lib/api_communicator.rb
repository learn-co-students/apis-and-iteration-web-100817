require 'rest-client'
require 'json'
require 'pry'

=begin
def get_character_movies_from_api(character) #working
  #make the web request
  films = []
  films_hash = []
  character_hash = get_characters_hash
  character_hash["results"].each do |char| #an array, with information about each character
    if char["name"].downcase == character.downcase #if the element matches the character argument
      films = char["films"] #store the films #films, an array of links to their films
    end#we should iterate through these links, fetching and parsing the data for our list
  end
films_hash = films.map { |link| RestClient.get(link) } 
films_hash = films_hash.map {|element| JSON.parse(element)} 
films_hash
=end


def get_character_movies_from_api(character) #working, less code, more function
  char_hash = get_characters_hash
  char = char_hash.find {|char| char["name"].downcase == character.downcase}
    films = char["films"]
  films_hash = films.map { |link| RestClient.get(link) } 
films_hash = films_hash.map {|element| JSON.parse(element)} 
films_hash
end



def parse_character_movies(films_hash) #working                                   
  films_hash.select.with_index do |film, index|
    puts "#{index+1}. Episode #{film["episode_id"]}: #{film["title"]}"
    puts "Release Date: #{film["release_date"]}"
  end
end

def get_movies_info(film_name) #bonus
  films_hash = get_character_movies_from_api
      if film["title"] == requested_film
        current_film = film
      end 
  film
end

def show_character_movies(character) #working
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

def get_character_data(character) #bonus
  films_hash = get_character_movies_from_api(character)
  get_movies_info(films_hash)
end


def get_characters_hash #working - add results key to hash, directly pull results 
  characters = RestClient.get('http://www.swapi.co/api/people/')
  char_hash = JSON.parse(characters)["results"]
  char_hash
end

def get_movie_list #bonus_main_component
  films = []
  film_hash = []
  char_hash = get_characters_hash
  char_hash.collect do |person|
    films << person["films"]
  end
  films = films.uniq
end



  
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
