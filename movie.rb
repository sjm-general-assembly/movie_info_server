
#
# create a simple class to store movie related fields
#    such as: title, year, and id
#
class Movie
    attr_accessor :title, :year, :id

    def initialize(new_title="", new_year="", new_id="")
      @title = new_title
      @year = new_year
      @id = new_id
    end
end

