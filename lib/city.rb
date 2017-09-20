class City

  attr_reader :id
  attr_accessor :name, :train_id

  def initialize(attributes)
    @id = (attributes.key?(:id) ? attributes.fetch(:id) : nil)
    @name = attributes.fetch(:name)
    @train_id = (attributes.key?(:train_id) ? attributes.fetch(:train_id) : nil)
  end

  def self.city_array(arr)
    cities = []
    arr.each() do |city|
      id = city.fetch("id")
      name = city.fetch("name")
      train_id = city.fetch("train_id")
      cities.push(City.new({:id => id, :name => name, :train_id => train_id}))
    end
    cities
  end

  def save()
    result = DB.exec("INSERT INTO city (name) VALUES ('#{name}';) RETURNING id;")
    @id = result.first().fetch("id")
  end

  def self.all
    returned_cities = DB.exec("SELECT * FROM city;")
    self.city_array(returned_cities)
  end

  def self.find_city(train)
    city_info = DB.exec("SELECT * FROM city WHERE train = '#{train}';")
    self.city_array(city_info)
  end

  def ==(another_city)
    self.name().==(another_city.name())
  end

end
