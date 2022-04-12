class Station # Класс Station (Станция)
  @@all_stations = []
  @instances = 0

  class << self
    attr_accessor :instances
  end

  include InstanceCounter

  def initialize(name)
    # Имеет название, которое указывается при ее создании
    @name = name
    @trains = [] # все поезда на станции
    #@trains_type_cargo = [] # грузовые поезда;
    #@trains_type_passenger = [] # пассажирские поезда
    @@all_stations << self
    register_instance

  end

  def self.all
    @@all_stations

  end

  # Может принимать поезда (по одному за раз)
  def arrival(train)
    #@station.insert(0, train)
    @trains.push(train) #poprobovat @trains << train
    #if train.type == :cargo
    #  @trains_type_cargo.push(train.type)
    #elsif train.type == :passenger
    #  @trains_type_passenger.push(train.type)
    #end
  end

  # ридер :name, чтобы можно было в машрут забирать только названия станций
  attr_reader :name, :trains # Может возвращать список всех поездов на станции, находящихся в текущий момент

  #def list_trains
  #  @trains
  #end

  # Может возвращать список поездов на станции по типу кол-во грузовых, пассажирских
  #def trains_by_type
  def trains_by_type(type)
    puts trains.select {|train| train.type == type}.count # без .count - по типу, а с .count - сосчитает

    #@trains_type_cargo.each { |cargo| puts cargo }
    #@trains_type_passenger.each { |passenger| puts passenger } # ruby всегда чё-то возвращает, а each - массив
    #[tipg, tipp].flatten.each
    #nil - можно закрывать, чтобы метод не возвращал кучу данных в ответе
    #puts Train::TYPE
    #[@trains_type_cargo, @trains_type_passenger].flatten.tally

  end

  def list_trains
    trains.each {|train| puts train}
  end

  # Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
  def dispatch(train)
    @trains.delete(train)
    #if train.type == :cargo
    #  @trains_type_cargo.delete_at(-1)
    #elsif train.type == :passenger
    #  @trains_type_passenger.delete_at(-1)
    #end
  end

end
