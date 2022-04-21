class Wagon

  include Manufacturer

  attr_reader :wagon_type

  def initialize(type)
    @wagon_type = type
  end
end
