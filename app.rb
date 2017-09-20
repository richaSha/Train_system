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
  @train_list = Train.all()
  erb(:train_list)
end
