require 'rspec'
require 'pg'
require 'train'
require 'city'
require 'pry'

DB = PG.connect({:dbname => 'train_system_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM train *")
    DB.exec("DELETE FROM city *;")
  end
end
