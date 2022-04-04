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