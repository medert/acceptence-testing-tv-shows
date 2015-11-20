require 'sinatra'
require 'csv'
require 'pry'
require_relative "app/models/television_show"

set :views, File.join(File.dirname(__FILE__), "app/views")

@error = ''

get "/television_shows" do
  @shows = CSV.parse(File.read('television-shows.csv'))
  erb :index
end


get "/television_shows/new" do
  erb :new
end


post "/television_shows/new" do
      @title = params["Title"].to_str
      @network = params["Network"].to_str
      @starting_year = params["Starting Year"].to_str
      @synopsis = params["Synopsis"].to_str
      @genre = params["Genre"].to_str
      @error = "ERROR: The show has already added!"

      array = []
      CSV.foreach('television-shows.csv',headers:true) do |row|
        array << row[0]
      end

      if array.include?(@title)
          erb :new
      else
          CSV.open('television-shows.csv', "a+") do |csv|
            csv << [@title, @network, @starting_year, @synopsis, @genre]
          end
        redirect "/television_shows"
      end

end
