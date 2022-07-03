# frozen_string_literal: true

class Wagon
  include Manufacturer

  attr_reader :wagon_type, :occupied_space, :total_space

  private_class_method :new

  def initialize(type, total_space)
    @wagon_type = type
    @total_space = total_space
    @occupied_space = 0
  end

  def remaining_space
    total_space - occupied_space
  end
end
