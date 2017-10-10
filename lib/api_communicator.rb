require 'rest-client'
require 'json'
require 'pry'

def get_data_from_api_for_people
  raw_data = RestClient.get('http://www.swapi.co/api/people/')
  data = JSON.parse(raw_data)
end

def get_data_from_api_for_films
  raw_data = RestClient.get('http://www.swapi.co/api/films/')
  data = JSON.parse(raw_data)
end

def get_character_movies(character)
  #make the web request
  data = get_data_from_api_for_people
  character_info = data["results"].find {|char| char["name"].downcase == character}
  character_films = character_info["films"]
  character_films.collect do |film|
    film_raw_data = RestClient.get(film)
    film_data = JSON.parse(film_raw_data)
  end
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

def get_movie_data(movie)
  data = get_data_from_api_for_films
  movie_info = data["results"].find {|mov| mov["title"].downcase == movie}
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.sort_by {|film| film["episode_id"]}.each.with_index do |film, index|
    puts "#{index + 1}. Episode #{film["episode_id"]}: #{film["title"]}"
    puts ""
    puts film["opening_crawl"]
    puts ""
  end
end

def parse_movie_data(movie_hash)
  puts "Episode #{movie_hash["episode_id"]}: #{movie_hash["title"]}"
  puts "Released: #{movie_hash["release_date"]}"
end

def show_character_movies(character)
  films_hash = get_character_movies(character)
  puts "\nDisplaying movies that contain #{character}\n\n"
  parse_character_movies(films_hash)
end

def show_movie_details(movie)
  movie_hash = get_movie_data(movie)
  parse_movie_data(movie_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
