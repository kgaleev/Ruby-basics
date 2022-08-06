# frozen_string_literal: true

class Route
  @instances = 0

  class << self
    attr_accessor :instances
  end

  include InstanceCounter

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    register_instance
    # @last_station = last_station # для проверки при движении поезда до конечной
    validation!
  end

  attr_reader :stations

  # attr_reader :last_station

  def validation!
    # raise "Station can't be string" if @stations[0].is_a?(String) || @stations[1].is_a?(String) #working
    # raise "Station can't be string" if @stations.each {|station| station.is_a?(String)}
    # #not working - .each returns self
    # raise "Station can't be number" if @stations[0].is_a?(Integer) || @stations[1].is_a?(Integer) #working
    return if @stations[0].instance_of?(Station) && @stations[1].instance_of?(Station)

    raise 'Only created stations can be put as arguments'
    # end
    # raise "Only created stations can be put as arguments" unless @stations.all?(Station)
    # #not working without block, while [q,w].all?(Station) => true
  end

  def valid?
    validation!
    true
  rescue StandardError
    false
  end

  def add_station(station)
    # Может добавлять промежуточную станцию в список
    @stations.insert(-2, station) # промежуточные могут добавляться между ними
  end

  def remove_station(station)
    # Может удалять промежуточную станцию из списка
    @stations.delete(station)
  end

  # Может выводить список всех станций по-порядку от начальной до конечной
  def list_stations
    puts @stations # peredelat na ['Алексей', 'Евгений'].each { |name| puts name }
  end
end
