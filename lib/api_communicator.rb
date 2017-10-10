require 'rest-client'
require 'json'

def rubyize(url)
  info = JSON.parse(RestClient.get(url))
end

def get_character_movies_from_api(character)
  film_urls = []
  character_hash = rubyize("http://www.swapi.co/api/people/")
  character_hash["results"].each do |char|
    film_urls = char["films"] if char["name"].downcase == character
  end
  film_urls.map{|url| rubyize(url)}
end

def parse_character_movies(film_list)
  film_list.each do |film|
    puts "Episode #{film["episode_id"]}: #{film["title"]}"
    puts "Released: #{film["release_date"]}"
    puts "Directed by: #{film["director"]}"
    puts "Produced by: #{film["producer"]}\n\n"
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end
