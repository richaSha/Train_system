require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/train")
require("./lib/city")
require("./lib/login")
require("pg")
require("pry")

DB = PG.connect({:dbname => "train_system"})

get("/") do
  erb(:login)
end

post("/") do
  user_name = params.fetch("user")
  password = params.fetch("password")
  action = params.fetch("data")
  if action == "login"
    is_admin = Login.is_admin?(user_name,password)
    if is_admin
      @currentuser = 'Admin'
      erb(:index)
    else
      result = Login.is_creditial_exist?(user_name,password)
      if result
        @currentuser = Login.find_current_user()
        erb(:index)
      else
        @error = "Sorry credentials does not match"
        erb(:login)
      end
    end
  elsif action == "signup"
    is_available = Login.is_username_unique?(user_name)
    if is_available
      new_user = Login.new({:username => user_name, :password => password, :currentuser => true})
      new_user.save()
      @currentuser = Login.find_current_user()
      erb(:index)
    else
      @error = "Sorry User Name is not available"
      erb(:login)
    end
  end

end

get('/logout/:user') do
  Login.logout(params[:user])
  erb(:login)
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
  name = params[:name]
  @train_info = Train.find_train_by_name(name)
  erb(:train_info)
end

get('/city_info/:name') do
  @city = params[:name]
  @city_info = Train.find_train(@city)
  erb(:city_info)
end

post('/new_train_info/:name') do
  name = params[:name]
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

get('/edit_city/:city/:train') do
  @city = params[:city]
  @train = params[:train]
  erb(:city_edit_form)
end

get('/edit_train/:city/:train') do
  @city = params[:city]
  @train = params[:train]
  erb(:train_edit_form)
end

patch("/") do
  if params.fetch('action') == "city"
    @city = params.fetch('old_city')
    train = params.fetch('old_name')
    new_name = params.fetch('train')
    new_time = params.fetch('time')
    Train.edit_info({:new_name => new_name, :new_city => @city, :new_time => new_time, :name => train, :city => @city})
    @city_info = Train.find_train(@city)
    erb(:city_info)
  elsif params.fetch('action') == "train"
    @city = params.fetch('old_city')
    train = params.fetch('old_name')
    city = params.fetch('city')
    new_time = params.fetch('time')
    Train.edit_info({:new_name => train, :new_city => city, :new_time => new_time, :name => train, :city => @city})
    @train_info = Train.find_train_by_name(train)
    erb(:train_info)
  end
end

delete("/") do
  time = params.fetch('time')
  city = params.fetch('city')
  train = params.fetch('train')
  Train.delete_info({:train => train, :city => city, :time => time})
  if params.fetch('action') == "city"
    @city_list = City.all()
    erb(:city_list)
  elsif params.fetch('action') == "train"
    train_list = Train.all()
    @train_name_lists = Train.unique_name_list(train_list)
    erb(:train_list)
  end

  get('/ticket') do
    @train_list = Train.all()
    erb(:ticket)
  end

end
