class Train

  attr_reader :id
  attr_accessor :name, :city, :time

  def initialize(attributes)
    @id = (attributes.key?(:id) ? attributes.fetch(:id) : nil)
    @name = attributes.fetch(:name)
    @city = (attributes.key?(:city) ? attributes.fetch(:city) : nil)
    @time = (attributes.key?(:time) ? attributes.fetch(:time) : nil)
  end

  def save()
    result = DB.exec("INSERT INTO train (name, city, time) VALUES ('#{name}', '#{city}', '#{time}') RETURNING id;")
    @id = result.first().fetch("id")
  end

  def self.train_array(arr)
    trains = []
    arr.each() do |train|
        name = train.fetch("name")
        city = train.fetch("city")
        time = train.fetch("time")
        id = train.fetch("id")
        trains.push(Train.new({:id => id, :name => name, :city => city, :time => time}))
      end

    trains
  end

  def self.unique_name_list(arr)
    lists =[]
    arr.each do |list|
      if !lists.include?(list.name)
        lists.push(list.name)
      end
    end
    lists
  end

  def self.all
    returned_trains = DB.exec("SELECT * FROM train;")
    self.train_array(returned_trains)
  end

  def self.find_train(city)
    train_info = DB.exec("SELECT * FROM train WHERE city = '#{city}';")
    self.train_array(train_info)
  end

  def self.find_train_by_name(name)
    train_info = DB.exec("SELECT * FROM train WHERE name = '#{name}';")
  end

  def ==(another_train)
    self.name().==(another_train.name()).&(self.city().==(another_train.city())).&(self.time().==(another_train.time()))
  end

  def self.edit_info(attributes)
    new_name = attributes.fetch(:new_name)
    new_city = attributes.fetch(:new_city)
    new_time = attributes.fetch(:new_time)
    name = attributes.fetch(:name)
    city = attributes.fetch(:city)
    DB.exec("UPDATE train SET name = '#{new_name}', city = '#{new_city}', time = '#{new_time}' WHERE name = '#{name}' AND city = '#{city}'; ")
  end

  def self.delete_info(attributes)
    train = attributes.fetch(:train)
    city = attributes.fetch(:city)
    time = attributes.fetch(:time)
    DB.exec("DELETE FROM train WHERE name = '#{train}' AND city = '#{city}' AND time = '#{time}';")
  end
end
