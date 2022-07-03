# frozen_string_literal: true

# require_relative 'manufacturer'

# Класс Train (Поезд)
class Train
  @@trains = []
  # TYPE = [:passanger, :cargo]

  # class Train; TYPE = [:passanger, :cargo]; end
  # Константа - это любое значение, не обязательно массив; ее можно использовать и в других классах, обращаясь так: Train::TYPES.

  include Manufacturer
  include InstanceCounter

  # @instances = 0

  class << self
    attr_accessor :instances
  end

  private_class_method :new

  # Имеет номер (произвольная строка) и тип (грузовой, пассажирский) #и количество вагонов, эти данные указываются при создании экземпляра класса
  # , wagons) # initialize должен быть выше других методов
  def initialize(number, type)
    @number = number
    @@trains << self
    @type = type # здесь к типу ещё нельзя обращаться
    # @wagons = (1..wagons).to_a
    @wagons = [] # При добавлении вагона к поезду, объект вагона должен передаваться как аргумент метода и сохраняться во внутреннем массиве поезда
    @speed = 0
    register_instance
    train_check!
    # self.class.instances +=1
    # @current_station -- без значения это не инициализация, а обращение; т.е. бесполезная строка
  end

  def train_check!
    # raise "Whole number only" unless @number.is_a?(Integer)
    unless @number =~ /^\w{3}-?\w{2}$/
      raise 'Format should be: 3 letters (or numbers) - 2 letters (or numbers); ex: ab2-3a'
    end
  end

  def valid?
    train_check!
    true
  rescue StandardError
    false
  end

  def self.find(train_number)
    @@trains.find { |train| train.number == train_number }
  end

  # Может принимать маршрут следования (объект класса Route).
  def set_route(route)
    # @index = 0
    @route = route
    # При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
    @current_station_index = 0
    route.stations[@current_station_index].arrival(self)
    # @current_station = route.stations[@current_station_index]
    # @next_station = route.stations[@index + 1]
    # @past_station = route.stations[@index - 1]
  end

  attr_reader :number, :route, :type, :wagons

  # attr_reader :type -- можно обращаться к типу извне

  # Может возвращать количество вагонов
  def wagons_count
    wagons.count
    # @wagons
    # можно сравнивать через a.wagons[2].object_id , чтобы объекты не дублировались
  end

  # Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.

  def add_wagon(wagon)
    if @speed.zero? && @type == wagon.wagon_type
      @wagons.push(wagon) # @wagons << wagons
    elsif @speed.zero? && @type != wagon.wagon_type
      puts 'dis iz rong! ┗(｀o ´)┓'

    elsif @speed != 0
      puts 'Саш, ну поезд же едет, ну ты чего? ޏ₍ὸ.ό₎ރ'
    end
  end

  def delete_wagon(wagon)
    if @speed.zero?
      @wagons.delete(wagon)
      # @wagons.delete_at(-1)

    else
      puts 'Саш, ну поезд же едет, ну ты чего? ޏ₍ὸ.ό₎ރ'
    end
  end

  # Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  def forward
    # тут нужна проверка на последнюю станцию, иначе поезд может уехать в пустоту
    # if @current_station_index != -1
    # @current_station = route.stations[@current_station_index]
    route.stations[@current_station_index].dispatch(self) # удаление поезда с текущей станции
    # end
    # next_station = to_route[1]
    @current_station_index += 1
    # @index += 1
    # @current_station = route.stations[@current_station_index]
    route.stations[@current_station_index].arrival(self) # вызов объекта другого класса с его методом
  end

  def back
    if @current_station_index.positive?
      # @current_station.dispatch(self)
      route.stations[@current_station_index].dispatch(self) # из-за того, что убрал инициализацию current_station, получилась вот такая жесть. Имхо лучше бы оставил
      @current_station_index -= 1
      # @current_station = route.stations[@current_station_index]
      route.stations[@current_station_index].arrival(self)
      # @current_station.arrival(self)
    end
    # @current_station_index -= 1
    # @current_station = route.stations[@index]
    # @current_station.arrival(self)
  end

  # Может возвращать текущую скорость
  attr_accessor :speed

  # Может набирать скорость

  # Может тормозить (сбрасывать скорость до нуля)
  def break
    super_complex_method_break
    # self.speed(0) - не будет работать с геттером attr_reader :speed
  end

  # Возвращать предыдущую станцию, текущую, следующую, на основе маршрута / (past, current, next)
  # attr_reader :current_station, :next_station, :past_station

  def current_station
    @current_station = route.stations[@current_station_index]
  end

  def next_station
    @next_station = route.stations[@current_station_index + 1]
  end

  def past_station
    @past_station = route.stations[@current_station_index - 1]
  end

  # b = proc {|wagons| puts "#{wagons}"}
  def wagons_puts_with_block(&b)
    b.call(wagons)
  end

  # так не работает блок как аргумент
  # def wagons_2(&{|wagons| puts "#{wagons}"})
  #   {|wagons| puts "#{wagons}"}.call(wagons)
  # end

  # def f1(string)
  #   puts string
  # end
  #
  # def f2
  #   f1(123)
  # end

  protected

  # пользователю не нужна супер сложная функция торможения, но она нужна подклассам в случае переопределения
  def super_complex_method_break
    self.speed = 0
  end
end
