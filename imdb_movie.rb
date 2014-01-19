
#
# create a simple class to store movie related fields
#    such as: title, year, and id
#
class IMDB_Movie
    attr_accessor :title, :year, :imdb_id, :imdb_url, :poster_url, :plot, :released, :rated,
    							:runtime, :genre, :director, :actors

    def initialize(title="", year="", imdb_id="")
      @title = title
      @year = year
      @imdb_id = imdb_id
      @imdb_url = ""
      @poster_url = ""
      @plot = ""
      @released = ""
      @rated = ""
      @runtime = ""
      @genre = ""
      @director = ""
      # NOTE: storing actors as an array of strings, instead of one long string.
      @actors = []
    end

    def get_imdb_fields(imdb_result)
      @title = imdb_result["Title"]
      @year = imdb_result["Year"]
      @imdb_id = imdb_result["imdbID"]
      @poster_url = imdb_result["Poster"]
      @plot = imdb_result["Plot"]
      @released = imdb_result["Released"]
      @rated = imdb_result["Rated"]
      @runtime = imdb_result["Runtime"]
      @genre = imdb_result["Genre"]
      @director = imdb_result["Director"]
      @actors = imdb_result["Actors"].split(',')
      @imdb_url = "http://www.imdb.com/title/#{imdb_result["imdbID"]}/"
    end
end

#  SAMPLE return movie hash
# {"Title":"Batman",
#   "Year":"1989",
#   "Rated":"PG-13",
#   "Released":"23 Jun 1989",
#   "Runtime":"126 min",
#   "Genre":"Action, Thriller",
#   "Director":"Tim Burton",
#   "Writer":"Bob Kane (Batman characters), Sam Hamm (story), Warren Skaaren (screenplay)",
#   "Actors":"Michael Keaton, Jack Nicholson, Kim Basinger, Robert Wuhl",
#   "Plot":"The Dark Knight of Gotham City begins his war on crime with his first major enemy being the clownishly homicidal Joker.",
#   "Language":"English, French",
#   "Country":"USA, UK",
#   "Awards":"Won 1 Oscar. Another 8 wins & 21 nominations.",
#   "Poster":"http://ia.media-imdb.com/images/M/MV5BMTYwNjAyODIyMF5BMl5BanBnXkFtZTYwNDMwMDk2._V1_SX300.jpg",
#   "Metascore":"66",
#   "imdbRating":"7.6",
#   "imdbVotes":"205,036",
#   "imdbID":"tt0096895",
#   "Type":"movie",
#   "Response":"True"}

