# frozen_string_literal: true

class PassengerTrain < Train
  public_class_method :new

  @instances = 0
  # , type = :passenger)#, wagons)
  def initialize(number)
    super(number, :passenger)
    # @type = :passenger
  end
end
