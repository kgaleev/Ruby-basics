class Wagon

  include Manufacturer

  attr_reader :wagon_type#, :seats

  private_class_method :new

  def initialize(type)
    @wagon_type = type
    #@seats = seats
  end
end
