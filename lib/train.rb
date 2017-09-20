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
    @id = DB.exec("INSERT INTO train (name, city, time) VALUES ('#{name}', '#{city}', '#{time}') RETURNING id;")
  end

  def self.all
    returned_trains = DB.exec("SELECT * FROM train;")
    trains = []
    returned_trains.each() do |train|
      name = train.fetch("name")
      city = train.fetch("city")
      time = train.fetch("time")
      id = train.fetch("id")
      trains.push(Train.new({:id => id, :name => name, :city => city, :time => time}))
    end
    trains
  end
end
