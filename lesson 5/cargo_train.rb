class CargoTrain < Train

  public_class_method :new

  @instances = 0
  def initialize(number)#=, type = :cargo)#, wagons)
    # вынести отдельно @type = :cargo, чтобы не было доступа
    #@type = :cargo
    super(number, :cargo)
    #super(number, :cargo)
  end
end
