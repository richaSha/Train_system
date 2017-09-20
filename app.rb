require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/train")
require("./lib/city")
require("pg")
require("pry")

DB = PG.connect({:dbname => "train_system"})

get("/") do
  erb(:index)
end

get('/train_list') do
  train_list = Train.all()
  @train_name_lists = Train.unique_name_list(train_list)
  erb(:train_list)
end

get('/city_list') do
  @city_list = City.all()
  erb(:city_list)
end

get('/train_info/:name') do
  name = params.fetch(:name)
  @train_info = Train.find_train_by_name(name)
  erb(:train_info)
end

get('/city_info/:name') do
  @city = params.fetch(:name)
  @city_info = Train.find_train(@city)
  erb(:city_info)
end
