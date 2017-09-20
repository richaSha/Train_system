class City

  attr_reader :id
  attr_reader :name, :train_id

  def initialize(attributes)
    @id = (attributes.key?(:id) ? attributes.fetch(:id) : nil)
    @name = attributes.fetch(:name)
    @train_id = (attributes.key?(:train_id) ? attributes.fetch(:train_id) : nil)
  end
end

def self.city_array(arr)
  cities = []
  arr.each() do |city|
    name = train.fetch("name")
    cities.push(City.new({:id => id, :name => name, :train_id => train_id}))
  end
  cities
end

def save()
  result = DB.exec("INSERT INTO train (name, train_id) VALUES ('#{name}', '#{city}') RETURNING id;")
  @id = result.first().fetch("id")
end

def self.all
  returned_cities = DB.exec("SELECT * FROM city;")
  self.city_array(returned_cities)
end
