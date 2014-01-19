require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'
require './imdb_movie'

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

  # if no string has been entered, stay on same page
  # (should post a message, and handle more gracefully)
  redirect "/" if search_str.empty?
  
# binding.pry

  # Create a request to OMDB API, search (param is 's') for movie titles
  response = Typhoeus.get("www.omdbapi.com", :params => {:s => search_str})

  # store result in a hash, for better parsing
  result_hash = JSON.parse(response.body)
  # binding.pry

  # {"Response"=>"False", "Error"=>"Movie not found!"}
  if result_hash.empty? || result_hash.has_key?("Search") == false 
    @page_error = true
  else
    @page_error = false 
    @movie_list = []
    result_hash["Search"].each { |h| @movie_list << IMDB_Movie.new(h["Title"], h["Year"], h["imdbID"]) }

    # sort the movie list, before displaying
    @movie_list.sort! { |x, y| x.year <=> y.year}
  end

  @page_title = "Movie Search Results"
  @page_header = "Movie Results"
  
  erb :results

end

get '/poster/:imdb_id' do |imdb_id|
  # Make another api call here to get the url of the poster.
  response = Typhoeus.get("www.omdbapi.com", :params => {:i => imdb_id})

  # store result in a hash, for better parsing
  result_hash = JSON.parse(response.body)

  # create a temp/local movie object to extract and store retrieved movie info
  @movie = IMDB_Movie.new
  @movie.get_imdb_fields(result_hash)

  @page_title = "Movie Search Results"
  @page_header = "Movie Results"  

  erb :movie_poster

end

get '/about' do
  @page_title = "About"

  erb :about

end
