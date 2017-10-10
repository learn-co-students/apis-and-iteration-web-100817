require 'rest-client'
require 'json'
require 'pry'


#Fabiano Commit

def get_character_movies_from_api(character)
  #make the web request
  character_hash = url_hasher('http://swapi.co/api/people')
  characters = character_getter(character_hash)
  until character_hash["next"] == nil
    character_hash = url_hasher(character_hash["next"])
    characters.merge!(character_getter(character_hash))
  end
  parse_character_movies(characters)

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def parse_character_movies(characters)
  # some iteration magic and puts out the movies in a nice list
  films_hash = url_hasher('https://swapi.co/api/films/')
  films = {}
  films_hash["results"].each do |film|
    films[film["url"]] = film["title"]
  end
  characters.each do |character, film_list|
    characters[character] = film_list.collect {|film| films[film]}
  end


end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  movie_list = films_hash[character]
  movie_list.each {|movie| puts movie}
end

def url_hasher(url)
  json_data = RestClient.get(url)
  hash_data = JSON.parse(json_data)
  hash_data
end

def character_getter(character_hash)
  characters = {}
  character_hash["results"].each do |character|
    characters[character["name"].downcase] = character["films"]
  end
  characters
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
