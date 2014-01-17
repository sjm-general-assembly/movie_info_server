require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'
require './movie'

require 'pry'

#
# Create and display (on get) original movie search page / form
#
get '/' do
  @page_title = "Movie Search"
  @page_header = "Find a Movie!"

  erb :search
end

post '/result' do
  search_str = params[:movie]
  
# binding.pry

  # Create a request to OMDB API, search (param is 's') for movie titles
  response = Typhoeus.get("www.omdbapi.com", :params => {:s => search_str})

  # store result in a hash, for better parsing
  result_hash = JSON.parse(response.body)
  # binding.pry
  @movie_list = []
  result_hash["Search"].each { |h| @movie_list << Movie.new(h["Title"], h["Year"], h["imdbID"]) }

  # sort the movie list, before displaying
  @movie_list.sort! { |x, y| x.year <=> y.year}

  @page_title = "Movie Search Results"
  @page_header = "Movie Results"
  
  erb :results

end

get '/poster/:imdb_id' do |imdb_id|
  # Make another api call here to get the url of the poster.
  response = Typhoeus.get("www.omdbapi.com", :params => {:i => imdb_id})

  # store result in a hash, for better parsing
  result_hash = JSON.parse(response.body)

  # extract the poster URL
  @poster_url = result_hash["Poster"]
  # TODO  @movie_title = result_hash["Title"]   ???

  @page_title = "Movie Search Results"
  @page_header = "Movie Results"  

  erb :movie_poster

end

