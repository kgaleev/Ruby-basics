class PassengerTrain < Train
  @instances = 0
  def initialize(number)#, type = :passenger)#, wagons)
    super(number, :passenger)
    #@type = :passenger
  end
end