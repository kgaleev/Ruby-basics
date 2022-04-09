#require_relative 'manufacturer'

class Train # Класс Train (Поезд)
  @@trains = []
  #TYPE = [:passanger, :cargo]
  # чтобы иметь перечисление неких значений в классе используют константы и массивы, например:
  # class Train; TYPE = [:passanger, :cargo]; end
  # Константа - это любое значение, не обязательно массив; ее можно использовать и в других классах, обращаясь так: Train::TYPES.

  #include Manufacturer
  extend Manufacturer

  # Имеет номер (произвольная строка) и тип (грузовой, пассажирский) #и количество вагонов, эти данные указываются при создании экземпляра класса
  def initialize(number, type)#, wagons) # initialize должен быть выше других методов
    @number = number
    @@trains << self
    @type = type # здесь к типу ещё нельзя обращаться
    #@wagons = (1..wagons).to_a
    @wagons = [] #При добавлении вагона к поезду, объект вагона должен передаваться как аргумент метода и сохраняться во внутреннем массиве поезда
    @speed = 0
    #@current_station -- без значения это не инициализация, а обращение; т.е. бесполезная строка
  end

  def self.find(train_number)
    @@trains.find {|train| train.number == train_number}

  end

    # Может принимать маршрут следования (объект класса Route).
  def set_route(route)
    #@index = 0
    @route = route
    # При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
    @current_station_index = 0
    route.stations[@current_station_index].arrival(self)
    #@current_station = route.stations[@current_station_index]
    # @next_station = route.stations[@index + 1]
    # @past_station = route.stations[@index - 1]
  end

  attr_reader :number, :route, :type, :wagons #, :current_station_index # index check
  #attr_reader :type -- можно обращаться к типу извне

  # Может возвращать количество вагонов
  def wagons_count
    wagons.count
    # @wagons
    # можно сравнивать через a.wagons[2].object_id , чтобы объекты не дублировались айди вагонов
  end

  # Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.

  def add_wagon(wagon)
    #if check_may_add_wagon(wagons)? == true
    if @speed == 0 && @type == wagon.wagon_type
      @wagons.push(wagon) #@wagons << wagons
    elsif @speed == 0 && @type != wagon.wagon_type
      puts "dis iz rong! ┗(｀o ´)┓"

    elsif @speed != 0
      puts "Саш, ну поезд же едет, ну ты чего? ޏ₍ὸ.ό₎ރ"
    end
  end

  def delete_wagon(wagon)
    if @speed == 0
      @wagons.delete(wagon)
      #@wagons.delete_at(-1)

    else
      puts "Саш, ну поезд же едет, ну ты чего? ޏ₍ὸ.ό₎ރ"
    end
  end

  #def check_may_add_wagon(wagon)
  #  @type == wagons.wagon_type
  #end

  # Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  def forward
    # тут нужна проверка на последнюю станцию, иначе поезд может уехать в пустоту
    #if @current_station_index != -1
    #@current_station = route.stations[@current_station_index]
    route.stations[@current_station_index].dispatch(self) # это удаление поезда с текущей станции
    #end
    #next_station = to_route[1]
    @current_station_index += 1
    #@index += 1
    #@current_station = route.stations[@current_station_index]
    route.stations[@current_station_index].arrival(self) # вызов объекта другого класса с его методом
    #current_station +=1
  end

  def back
    if @current_station_index > 0
      #@current_station.dispatch(self)
      route.stations[@current_station_index].dispatch(self) #из-за того, что убрал инициализацию current_station, получилась вот такая жесть. Имхо лучше бы оставил
      @current_station_index -= 1
      #@current_station = route.stations[@current_station_index]
      route.stations[@current_station_index].arrival(self)
      #@current_station.arrival(self)
    end
    #@index -= 1
    #@current_station_index -= 1
    #@current_station = route.stations[@index]
    #@current_station.arrival(self)
    #current_station -=1
  end

  # Может возвращать текущую скорость
  attr_reader :speed #или вообще знать о её существовании
  #def speed
  #  @speed
  #end

  # Может набирать скорость
  attr_writer :speed
  #def speed(speed)
  #  @speed = speed
  #end

  # Может возвращать текущую скорость
  attr_reader :speed
  #def speed
  #  @speed
  #end

  # Может тормозить (сбрасывать скорость до нуля)
  def break
    super_complex_method_break
    # self.speed(0) - не будет работать с геттером attr_reader :speed
    # speed(0)
  end

  # Возвращать предыдущую станцию, текущую, следующую, на основе маршрута / (past, current, next)
  #attr_reader :current_station, :next_station, :past_station

  def current_station
    @current_station = route.stations[@current_station_index]
  end

  def next_station
    @next_station = route.stations[@current_station_index + 1]
  end

  def past_station
    @past_station = route.stations[@current_station_index - 1]
  end

  protected

  def super_complex_method_break #пользователю не нужна супер сложная функция торможения, но она нужна подклассам в случае переопределения
    self.speed = 0
  end

end