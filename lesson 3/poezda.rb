class Station # Класс Station (Станция)
  def initialize(name)
    # Имеет название, которое указывается при ее создании
    @name = name
    @station = [] # все поезда на станции
    @tipg = [] # грузовые поезда
    @tipp = [] # пассажирские поезда
  end

  # Может принимать поезда (по одному за раз)
  def arrival(train)
    #@station.insert(0, train)
    @station.push(train) #poprobovat @station << train
    if train.tip == 1
      @tipg.push(train.tip)
    elsif train.tip == 2
      @tipp.push(train.tip)
    end
  end

  attr_reader :name # ридер, чтобы можно было в машрут забирать только названия станций

  # Может возвращать список всех поездов на станции, находящихся в текущий момент
  def spisok_all
    @station
  end

  # Может возвращать список поездов на станции по типу кол-во грузовых, пассажирских
  def spisok_tip
    @tipg.each { |tipg| puts tipg }
    @tipp.each { |tipp| puts tipp } # ruby всегда чё-то возвращает, а each - массив
    #[tipg, tipp].flatten.each
    #nil - можно закрывать, чтобы метод не возвращал кучу данных в ответе
    #puts Train::TYPE
    tipi = [@tipg, @tipp].flatten
    #@tipg.tally
    #@tipp.tally
    tipi.tally
  end

  # Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
  def otpravit(train)
    @station.delete(train)
    if train.tip == 1
      @tipg.delete_at(-1)
    elsif train.tip == 2
      @tipp.delete_at(-1)
    end
  end

end

class Route # Класс Route (Маршрут) Имеет начальную и конечную станцию, а также список промежуточных станций

  # хорошо бы куда-то воткнуть массив всех станций

  def initialize(start, finish)
    #Начальная и конечная станции указываютсся при создании маршрута
    @route = [nil, start, finish]
  end

  attr_reader :route

  def add_station(station)
    #Может добавлять промежуточную станцию в список
    @route.insert(-2, station) #промежуточные могут добавляться между ними
  end

  def remove_station(station)
    #Может удалять промежуточную станцию из списка
    @route.delete(station)
  end

  #Может выводить список всех станций по-порядку от начальной до конечной
  def list_station
    puts @route # peredelat na ['Алексей', 'Евгений'].each { |name| puts name }
  end

end

class Train # Класс Train (Поезд)
  #TYPE = [:passanger, :cargo]
  #@@ind = 0
  # Может принимать маршрут следования (объект класса Route).
  def set_route(route)
    @ind = 1
    @route = route
    # При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
    @current_station = route[@ind]
    @next_station = route[@ind + 1]
    @past_station = route[@ind - 1]
  end

  attr_reader :route

  #чтобы иметь перечисление неких значений в классе используют константы и массивы, например:
  # class Train; TYPE = [:passanger, :cargo]; end
  # Константа - это любое значение, не обязательно массив; ее можно использовать и в других классах, обращаясь так: Train::TYPES.
  # Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
  def initialize(nomer, tip, vagoni)
    @nomer = nomer
    #@tipg = []
    #@tipp = []
    @tip = tip # здесь к типу ещё нельзя обращаться
    @vagoni = (1..vagoni).to_a
    @speed
    @current_station
    @next_station
    @past_station
    #@train = [nomer, tip, vagoni]
  end

  attr_reader :tip # теперь можно обращаться к типу извне

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

  # Может тормозить (сбрасывать скорость до нуля)
  def tormoz
    self.speed = 0
    # self.speed(0) - не будет работать с геттером attr_reader :speed
    # speed(0)
  end

  # Может возвращать количество вагонов
  def sostav
    @vagoni
  end

  # Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
  def sostav_add(vagoni)
    if @speed == 0
      @vagoni.push(vagoni) #@vagoni << vagoni

    else
      puts "Саш, ну поезд же едет, ну ты чего? ޏ₍ὸ.ό₎ރ"
    end
  end

  def sostav_delete
    if @speed == 0
      @vagoni.delete_at(-1)

    else
      puts "Саш, ну поезд же едет, ну ты чего? ޏ₍ὸ.ό₎ރ"
    end
  end

  # Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  def go
    @ind += 1
    #next_station = route[1]
    @current_station = route[@ind]
    #current_station +=1
  end

  def back
    @ind -= 1
    @current_station = route[@ind]
    #current_station -=1
  end

  # Возвращать предыдущую станцию, текущую, следующую, на основе маршрута / (past, current, next)
  attr_reader :current_station, :next_station, :past_station

  def next_station
    @next_station = route[@ind + 1]
  end

  def past_station
    @past_station = route[@ind - 1]
  end

=begin
  def tablo
    if @ind == 0
      @current_station = route[@ind]
      @next_station = route[@ind + 1]
      #@current_station
      #@next_station
    elsif @ind > 0
      @current_station = route[@ind]
      @next_station = route[@ind + 1]
      @past_station = route[@ind - 1]
      #@current_station
      #@next_station
      #@past_station
    end

    #if @current_station == route[0]
    #  @next_station = route[@@ind+1]
    #  else
    #  @next_station = route[@@ind+1]
    #  @past_station = @route[@@ind-1]
    #end

  end
=end

end

=begin

q = Station.new('q')
w = Station.new('w')
e = Station.new('e')
a = Route.new(q.name, e.name)
a.add_station(w.name)
z = Train.new(1, 1, 1)
x = Train.new(2, 2, 2)
c = Train.new(3, 1, 1)
q.arrival(z)
q.arrival(x)
q.arrival(c)
z.set_route(a.route)
q.spisok_tip


=end
