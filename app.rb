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

post('/new_train_info/:name') do
  name = params.fetch(:name)
  city = params.fetch("city")
  time = params.fetch("time")
  train_object = Train.new({:name => name, :city => city, :time => time})
  train_object.save()
  @train_info = Train.find_train_by_name(name)
  erb(:train_info)
end

post('/new_train_list') do
  train = params.fetch("train")
  city = params.fetch("city")
  time = params.fetch("time")
  train_object = Train.new({:name => train, :city => city, :time => time})
  train_object.save()
  train_list = Train.all()
  @train_name_lists = Train.unique_name_list(train_list)
  erb(:train_list)
end

post('/new_city_list') do
  city = params.fetch("city")
  city_obj = City.new({:name => city})
  city_obj.save()
  @city_list = City.all()
  erb(:city_list)
end

get('/edit/:city/:train') do
  @city = params.fetch(:city)
  @train = params.fetch(:train)
  erb(:city_edit_form)
end

patch("/") do
  @city = params.fetch('old_city')
  train = params.fetch('old_name')
  new_name = params.fetch('train')
  new_time = params.fetch('time')
  Train.edit_info({:new_name => new_name, :new_city => @city, :new_time => new_time, :name => train, :city => @city})
  @city_info = Train.find_train(@city)
  erb(:city_info)
end

delete("/") do
  time = params.fetch('time')
  city = params.fetch('city')
  train = params.fetch('train')
  Train.delete_info({:train => train, :city => city, :time => time})
  @city_info = Train.find_train(@city)
  erb(:city_info)
end
