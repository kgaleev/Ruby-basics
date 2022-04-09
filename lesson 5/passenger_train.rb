class PassengerTrain < Train
  def initialize(number)#, type = :passenger)#, wagons)
    super(number, :passenger)
    #@type = :passenger
  end
end