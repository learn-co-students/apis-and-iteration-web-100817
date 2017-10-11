require 'rest-client'
require 'json'
require 'pry'


def get_specific_character(character)
  # n=1
  # arr =[]
  # while n < 10
  #   arr.push(RestClient.get("http://www.swapi.co/api/people/?page=#{n}"))
  #   n += 1
  # end
  #
  # character_hash = []
  #   arr.each do |x|
  #     character_hash.push(JSON.parse(x))
  #   end
  #   new_hash = character_hash.flatten
  #   better_hash = new_hash.map { |x| "'#{x}'"}.join(' ')
  #
  #
  # all_characters = 8.times do
  #   RestClient.get("http://www.swapi.co/api/people/?page=#{n}")
  #   n += 1
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  character_hash["results"].find do |character_info|
    character_info["name"].downcase == character

  end
end

def get_character_movies_from_api(character)
  #make the web request
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
  our_character = get_specific_character(character)
  films = our_character["films"]
  film_info = films.map { |film| JSON.parse(RestClient.get(film)) }
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  titles = films_hash.map do |film_info|
    film_info["title"]
  end
  titles.each_with_index do |film, index|
    puts "#{index + 1} #{film}"
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
