class City

  attr_reader :id
  attr_reader :name, :train_id

  def initialize(attributes)
    @id = (attributes.key?(:id) ? attributes.fetch(:id) : nil)
    @name = attributes.fetch(:name)
    @train_id = (attributes.key?(:train_id) ? attributes.fetch(:train_id) : nil)
  end
end
