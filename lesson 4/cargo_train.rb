class CargoTrain < Train
  def initialize(number)#=, type = :cargo)#, wagons)
    # вынести отдельно @type = :cargo, чтобы не было доступа
    #@type = :cargo
    super(number, :cargo)
    #super(number, :cargo)
  end
end