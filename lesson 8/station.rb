# frozen_string_literal: true

class Station
  @@all_stations = []
  @instances = 0

  class << self
    attr_accessor :instances
  end

  include InstanceCounter

  def initialize(name)
    @name = name
    @trains = [] # все поезда на станции
    @@all_stations << self
    register_instance
    station_name_check!
  end

  def self.all
    @@all_stations
  end

  def station_name_check!
    # raise "Name can't be nil! Put it in quotes" if name.nil? #== nil
    raise 'Only string can be here' unless @name.is_a?(String) # @name.respond_to?(:to_s)
    # raise ArgumentError, "Name can't be blank!" #if ArgumentError - not working
    # raise ArgumentError.new("Name can't be blank") - not working
  ensure
    puts '(´_ゝ`)'
  end

  def valid?
    station_name_check!
    true
  rescue StandardError
    false
  end

  def arrival(train)
    @trains.push(train)
  end

  attr_reader :name, :trains # Может возвращать список всех поездов на станции, находящихся в текущий момент

  def trains_by_type(type)
    puts trains.select { |train| train.type == type }.count # без .count - по типу, а с .count - сосчитает
  end

  def list_trains
    trains.each { |train| puts train }
  end

  def dispatch(train)
    @trains.delete(train)
  end

  # написать метод, который принимает блок и проходит по всем поездам на станции,
  # передавая каждый поезд в блок (station)
  # если используется &block (можно вместо block любое название),
  # то &block вызывается через call. Если без, то через yield
  def count_trains_with_block
    # q=Station.new('q')
    # d=CargoTrain.new("122ab")
    # f=CargoTrain.new("tyz-88")
    # q.arrival(d)
    # q.arrival(f)

    # q.count_trains_with_block { q.trains.each { |train| puts train}.count }
    # если в метод не передаётся аргумент в скобках
    # q.count_trains_with_block("test") { |station| puts "#{station}"}
    # если в метод передаётся аргумент в скобках
    yield # (station)
  end
end

# q.count_trains_with_block("test") do |station|
#   q.trains.each do |train|
#     puts "#{train}"
#   end.count
# end
#
# [1,2,3].each do |var, var2|
#   puts "V: #{var} V2: #{var2}"
# end
