# frozen_string_literal: true

class CargoTrain < Train
  public_class_method :new

  @instances = 0
  #=, type = :cargo)#, wagons)
  def initialize(number)
    # вынести отдельно @type = :cargo, чтобы не было доступа
    # @type = :cargo
    super(number, :cargo)
    # super(number, :cargo)
  end
end
