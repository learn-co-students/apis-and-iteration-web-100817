require 'rest-client'
require 'json'
require 'pry'

def fetch_starwars_characters
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  JSON.parse(all_characters)
end

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

def fetch_data_with_better_code
  page_characters = RestClient.get
end


def get_character_movies_from_api(character)
  #make the web request
  character_hash = all_fetch_starwars_characters
  character_films = []
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
  character_hash.each do |person_data|
    if person_data["name"] == character
      character_films = person_data["films"]
    end
  end
  character_films
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  film_array = []
  films_hash.each do |url|
    film_info = RestClient.get(url)
    film_info_parsed = JSON.parse(film_info)
    film_array << film_info_parsed["title"]
  end
  film_array
end


def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end
