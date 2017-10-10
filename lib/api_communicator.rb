require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character) #working
  #make the web request
  films = []
  films_hash = []
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  character_hash["results"].each do |char| #an array, with information about each character
    if char["name"].downcase == character.downcase #if the element matches the character argument
      films = char["films"] #store the films #films, an array of links to their films
    end#we should iterate through these links, fetching and parsing the data for our list
  end
films_hash = films.map { |link| RestClient.get(link) } 
films_hash = films_hash.map {|element| JSON.parse(element)} 
films_hash
end

def parse_character_movies(films_hash)   #helper method to parse the data in :films to extract information                                    #and print it in a nice list
  films_hash.select.with_index do |film, index|
    puts "#{index+1}. Episode #{film["episode_id"]}: #{film["title"]}"
    puts "Release Date: #{film["release_date"]}"
    puts "Description: #{film["opening_crawl"]}"
  end
end

def show_character_movies(character) 
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end



## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

 # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film
