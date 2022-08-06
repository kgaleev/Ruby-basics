# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'route'
require_relative 'station'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

# - Создавать станции
# - Создавать поезда
# - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
# - Назначать маршрут поезду
# - Добавлять вагоны к поезду
# - Отцеплять вагоны от поезда
# - Перемещать поезд по маршруту вперед и назад
# - Просматривать список станций и список поездов на станции

routes = []
trains = []
stations = []
# wagons = []

loop do # цикл
  puts
  puts 'Welcome to Railway builder PRO'
  puts 'Pick any operation number'
  puts '1. Create station'
  puts '2. Create train'
  puts '3. Create route'
  puts '4. Add station to route'
  puts '5. Delete station from route'
  puts '6. Add route to train'
  puts '7. Add wagon to train'
  puts '8. Delete wagon from train'
  puts '9. Move train forward'
  puts '10. Move train backward'
  puts '11. Show list of stations'
  puts '12. Show list of trains on station' # + "\n"
  puts '13. Book a seat or Load some cargo'
  puts '14. Show list of wagons for train'
  puts

  number = gets.chomp.to_i

  if number == 1
    puts 'Name the station'
    station_name = gets.chomp
    stations << Station.new(station_name)
    puts stations
  end

  if number == 2
    begin
      puts 'Enter train number in format: ab2-3a (letters or numbers)'
      train_number = gets.chomp
      raise unless train_number =~ /^\w{3}-?\w{2}$/

      puts 'Is your train cargo (1) or passenger (2)?'
      # type = gets.chomp.to_sym
      train_type = gets.chomp.to_i
      # if type == :cargo
      case train_type
      when 1
        trains << CargoTrain.new(train_number)
        puts "\n#{train_number} created!"
      when 2
        # elsif type == :passenger
        trains << PassengerTrain.new(train_number)
        puts "\n#{train_number} created!"
      end
    # else
    # raise
    # puts "Format should be: ab2-3a. Try again"
    #  end
    rescue StandardError
      puts "\nFormat should be: ab2-3a. Try again"
      retry
    end
    # puts trains
  end

  if number == 3
    puts 'Name first station in route'
    first_station_name = gets.chomp
    first_station =
      stations.find do |station|
        station.name == first_station_name
      end
    # если у объекта не вызвать метод для считывания,
    # будет пытаться объект сравнить со строкой, на выход отдавать nil

    # puts stations
    puts 'Name last station in route'
    last_station_name = gets.chomp
    last_station = stations.find { |station| station.name == last_station_name }
    # last_station = gets.chomp
    routes << Route.new(first_station, last_station)
    # route = Route.new(first_station, last_station)
    # route.list_stations
    # puts routes

    # join returns a string created by converting each element of the array to a string,
    # separated by the given separator

    routes.each do |route|
      puts "#{route} : #{route.stations.map(&:name).join(', ')}"
    end
  end

  if number == 4
    puts 'Name station to add'
    station_name = gets.chomp
    new_station = stations.find { |station| station.name == station_name }
    puts 'Choose route number'
    routes.each_with_index do |route, index|
      print index
      print ': '
      puts route
    end
    route_index = gets.chomp.to_i
    routes[route_index].add_station(new_station)
    routes[route_index].list_stations
  end

  if number == 5
    puts 'Name station to delete'
    delete_station = gets.chomp
    station_to_delete = stations.find { |station| station.name == delete_station }
    puts 'Choose route number'
    routes.each_with_index do |route, index|
      print index
      print ': '
      puts route
    end
    route_index = gets.chomp.to_i
    routes[route_index].remove_station(station_to_delete)
    routes[route_index].list_stations
  end

  if number == 6
    puts 'Choose route number'
    routes.each_with_index do |route, index|
      print index
      print ': '
      puts route
    end
    route_index = gets.chomp.to_i
    puts 'Enter train number'
    trains.each { |train| puts "#{train.number} : #{train}" }
    train_number = gets.chomp
    train = trains.find { |trn| trn.number == train_number }
    train.route = (routes[route_index])
    puts train.route
    puts train.route.stations[0].trains.each { |trn| puts "#{trn.number} : #{trn}" }
  end

  if number == 7
    puts 'Select train number'
    trains.each { |trn| puts "#{trn.number} : #{trn}" }
    puts "\n"
    train_number = gets.chomp
    train = trains.find { |trn| trn.number == train_number }
    case train.type
    when :cargo
      puts "\nSpecify capacity of a wagon"
      total_space = gets.chomp.to_i
      train.add_wagon(CargoWagon.new(total_space))
      puts "\nCargo wagon with capacity of #{total_space} added to Train #{train.number}"
      # puts "Cargo wagon #{CargoWagon.new(train.type, capacity)} added to Train #{train.number}"
    when :passenger
      puts "\nSpecify number of seats in a wagon"
      total_space = gets.chomp.to_i
      train.add_wagon(PassengerWagon.new(total_space))
      puts "\nPassenger wagon with #{total_space} seats added to Train #{train.number}"
    end
    puts train.wagons
  end

  if number == 8
    puts 'Select train number'
    trains.each { |trn| puts "#{trn.number} : #{train}" }
    train_number = gets.chomp
    train = trains.find { |trn| trn.number == train_number }
    train.wagons.delete_at(-1)
    puts train.wagons
  end

  if number == 9
    puts 'Enter train number'
    trains.each { |trn| puts "#{trn.number} : #{trn}" }
    train_number = gets.chomp
    train = trains.find { |trn| trn.number == train_number }
    train.forward
    puts train.current_station
  end

  if number == 10
    puts 'Select train number'
    trains.each { |trn| puts "#{trn.number} : #{trn}" }
    train_number = gets.chomp
    train = trains.find { |trn| trn.number == train_number }
    train.back
    puts train.current_station
  end

  stations.each { |station| puts station } if number == 11

  if number == 12
    puts 'Enter station'
    station_name = gets.chomp
    station = stations.find { |sttn| sttn.name == station_name }
    # station.list_trains
    if station.trains.empty? # if проверяет на true, a empty? возвращает true/false
      puts 'you notice a group of strangers staring at you ༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽'
      puts 'seems like you did something not acceptable'
    else
      # station.list_trains
      station.count_trains_with_block { station.trains.each { |trn| puts trn } }
    end
  end

  if number == 13
    puts "\nEnter train number"
    trains.each { |trn| puts "#{trn.number} : #{trn}" }
    train_number = gets.chomp
    train = trains.find { |trn| trn.number == train_number }
    puts "\nChoose wagon"
    train.wagons.each_with_index do |wagon, index|
      print index
      print ': '
      puts wagon
    end
    wagon_index = gets.chomp.to_i
    case train.wagons[wagon_index].wagon_type
    when :cargo
      puts "\nEnter loading weight"
      weight = gets.chomp.to_i
      train.wagons[wagon_index].cargo_load = weight
      puts "\nRemaining capacity: #{train.wagons[wagon_index].remaining_space}"
    when :passenger
      train.wagons[wagon_index].book_seat
      puts "\nRemaining seats: #{train.wagons[wagon_index].remaining_space}"
    end
  end

  next unless number == 14

  puts "\nSelect train"
  trains.each_with_index do |trn, index|
    print index
    print ': '
    puts trn.number
  end
  train_index = gets.chomp.to_i
  puts "\nUse SUPERPOWER?"
  gets.chomp
  puts "\nBLOKACHU I PICK YOU ϞϞ(๑⚈․⚈๑)∩"
  puts
  b = proc { |wagons| puts wagons.to_s }
  trains[train_index].wagons_puts_with_block(&b)
  # trains[train_index]
end
