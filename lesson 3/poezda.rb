class Station # Класс Station (Станция)
  def initialize(name)
    # Имеет название, которое указывается при ее создании
    @name = name
    @trains = [] # все поезда на станции
    #@trains_type_cargo = [] # грузовые поезда;
    #@trains_type_passenger = [] # пассажирские поезда
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
    trains.select {|train| train.type == type}.count # без .count - по типу, а с .count - сосчитает

    #@trains_type_cargo.each { |cargo| puts cargo }
    #@trains_type_passenger.each { |passenger| puts passenger } # ruby всегда чё-то возвращает, а each - массив
    #[tipg, tipp].flatten.each
    #nil - можно закрывать, чтобы метод не возвращал кучу данных в ответе
    #puts Train::TYPE
    #[@trains_type_cargo, @trains_type_passenger].flatten.tally

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

class Route # Класс Route (Маршрут) Имеет начальную и конечную станцию, а также список промежуточных станций

  def initialize(first_station, last_station)
    #Начальная и конечная станции указываютсся при создании маршрута
    @stations = [first_station, last_station]
    # @last_station = last_station # для проверки при движении поезда до конечной
  end

  attr_reader :stations
  #attr_reader :last_station

  def add_station(station)
    #Может добавлять промежуточную станцию в список
    @stations.insert(-2, station) #промежуточные могут добавляться между ними
  end

  def remove_station(station)
    #Может удалять промежуточную станцию из списка
    @stations.delete(station)
  end

  #Может выводить список всех станций по-порядку от начальной до конечной
  def list_stations
    puts @stations # peredelat na ['Алексей', 'Евгений'].each { |name| puts name }
  end

end

class Train # Класс Train (Поезд)
  #TYPE = [:passanger, :cargo]
  # чтобы иметь перечисление неких значений в классе используют константы и массивы, например:
  # class Train; TYPE = [:passanger, :cargo]; end
  # Константа - это любое значение, не обязательно массив; ее можно использовать и в других классах, обращаясь так: Train::TYPES.

  # Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
  def initialize(number, type, wagons) # initialize должен быть выше других методов
      @number = number
      @type = type # здесь к типу ещё нельзя обращаться
      @wagons = (1..wagons).to_a
      @speed = 0

      #@current_station # без значение это не инициализация, а обращение; т.е. бесполезная строка
      #@next_station
      #@past_station

  end

  # Может принимать маршрут следования (объект класса Route).
  def set_route(route) #
    #@index = 0
    @route = route
    # При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
    @current_station_index = 0
    #@current_station = route.stations[@current_station_index]
    # @next_station = route.stations[@index + 1]
    # @past_station = route.stations[@index - 1]
  end

  attr_reader :route, :type, :wagons #, :current_station_index # index check

  #attr_reader :type # теперь можно обращаться к типу извне

  # Может набирать скорость
  attr_writer :speed
  #def speed(speed)
  #  @speed = speed
  #end

  # Может возвращать текущую скорость
  attr_reader :speed
  #def speed_check
  #  @speed
  #end

  # Может возвращать количество вагонов
  def wagons_count
    wagons.count
    # @wagons
  end

  # Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
  def add_wagon(wagon)
    if speed == 0
      wagons.push(wagon) #@wagons << wagons

    else
      puts "Саш, ну поезд же едет, ну ты чего? ޏ₍ὸ.ό₎ރ"
    end
  end

  def delete_wagon(wagon)
    if speed == 0
      wagons.delete_at(wagon)
      #@wagons.delete_at(-1)

    else
      puts "Саш, ну поезд же едет, ну ты чего? ޏ₍ὸ.ό₎ރ"
    end
  end

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

  # Может тормозить (сбрасывать скорость до нуля)
  def break
    self.speed = 0
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

=begin
  def tablo
    if @ind == 0
      @current_station = to_route[@ind]
      @next_station = to_route[@ind + 1]
      #@current_station
      #@next_station
    elsif @ind > 0
      @current_station = to_route[@ind]
      @next_station = to_route[@ind + 1]
      @past_station = to_route[@ind - 1]
      #@current_station
      #@next_station
      #@past_station
    end

    #if @current_station == to_route[0]
    #  @next_station = to_route[@@ind+1]
    #  else
    #  @next_station = to_route[@@ind+1]
    #  @past_station = @to_route[@@ind-1]
    #end

  end
=end

end

=begin
q = Station.new('q')
w = Station.new('w')
e = Station.new('e')
a = Route.new(q, e)
a.add_station(w)
z = Train.new(1, :cargo, 1)
x = Train.new(2, :cargo, 2)
c = Train.new(3, :passenger, 1)
q.arrival(z)
q.arrival(x)
q.arrival(c)
z.set_route(a)
x.set_route(a)
z.speed=50

nil
=end
