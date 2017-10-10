require 'rest-client'
require 'json'
require 'pry'

def get_data_from_api(type)
  raw_data = RestClient.get("http://www.swapi.co/api/#{type}/")
  data = JSON.parse(raw_data)
  ultimate_array = Array.new
  ultimate_array << data
  while ultimate_array[-1]["next"] != nil
    raw_data = RestClient.get("http://www.swapi.co/api/#{type}/?page=#{ultimate_array.length+1}")
    data = JSON.parse(raw_data)
    ultimate_array << data
  end
  ultimate_array
end

def get_character_movies(character)
  #make the web request
  data = get_data_from_api("people")
  character_info = nil
  data.each do |page|
    if page["results"].find {|char| char["name"].downcase == character}
      character_info = page["results"].find {|char| char["name"].downcase == character}
    end
  end
  if character_info
    character_films = character_info["films"]
    character_films.collect do |film|
      film_raw_data = RestClient.get(film)
      film_data = JSON.parse(film_raw_data)
    end
  else
    puts "Character not found!"
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
  data = get_data_from_api("films")
  movie_info = nil
  data.each do |page|
    if page["results"].find {|mov| mov["title"].downcase == movie}
      movie_info = page["results"].find {|mov| mov["title"].downcase == movie}
    end
  end
  if movie_info
    movie_info
  else
    puts "Movie not found!"
  end
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
  if films_hash = get_character_movies(character)
    puts "\nDisplaying movies that contain #{character}\n\n"
    parse_character_movies(films_hash)
  end
end

def show_movie_details(movie)
  movie_hash = get_movie_data(movie)
  parse_movie_data(movie_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
