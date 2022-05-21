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

=begin
- Создавать станции
- Создавать поезда
- Создавать маршруты и управлять станциями в нем (добавлять, удалять)
- Назначать маршрут поезду
- Добавлять вагоны к поезду
- Отцеплять вагоны от поезда
- Перемещать поезд по маршруту вперед и назад
- Просматривать список станций и список поездов на станции
=end

routes = []
trains = []
stations = []
#wagons = []

loop do #цикл

  puts
  puts "Welcome to Railway builder PRO"
  puts "Pick any operation number"
  puts "1. Create station"
  puts "2. Create train"
  puts "3. Create route"
  puts "4. Add station to route"
  puts "5. Delete station from route"
  puts "6. Add route to train"
  puts "7. Add wagon to train"
  puts "8. Delete wagon from train"
  puts "9. Move train forward"
  puts "10. Move train backward"
  puts "11. Show list of stations"
  puts "12. Show list of trains on station" # + "\n"
  puts "13. Book a seat or Load some cargo"
  puts "14. Show list of wagons for train"
  puts

  number = gets.chomp.to_i

  if number == 1
    puts "Name the station"
    station_name = gets.chomp
    stations << Station.new(station_name)
    puts stations
  end

  if number == 2
    begin
    puts "Enter train number in format: ab2-3a (letters or numbers)"
    train_number = gets.chomp
      if train_number =~ /^\w{3}-?\w{2}$/
        puts "Is your train cargo (1) or passenger (2)?"
        #type = gets.chomp.to_sym
        train_type = gets.chomp.to_i
        #if type == :cargo
        if train_type == 1
          trains << CargoTrain.new(train_number)
          puts "\n#{train_number} created!"
        elsif train_type == 2
        #elsif type == :passenger
          trains << PassengerTrain.new(train_number)
          puts "\n#{train_number} created!"
        end
      else
        raise
        #puts "Format should be: ab2-3a. Try again"
      end
    rescue
      puts "\nFormat should be: ab2-3a. Try again"
      retry
    end
    #puts trains
  end

  if number == 3
    puts "Name first station in route"
    first_station_name = gets.chomp
    first_station = stations.find {|station| station.name == first_station_name} #если у объекта не вызвать метод для считывания, будет пытаться объект сравнить со строкой, на выход отдавать nil
    #puts stations
    puts "Name last station in route"
    last_station_name = gets.chomp
    last_station = stations.find {|station| station.name == last_station_name}
    #last_station = gets.chomp
    routes << Route.new(first_station, last_station)
    #route = Route.new(first_station, last_station)
    #route.list_stations
    #puts routes
    routes.each {|route| puts "#{route} : #{route.stations.map {|station| station.name}.join(", ")}"} #join returns a string created by converting each element of the array to a string, separated by the given separator
  end

  if number == 4
    puts "Name station to add"
    station_name = gets.chomp
    new_station = stations.find {|station| station.name == station_name}
    puts "Choose route number"
    routes.each_with_index do |route, index|
      print index
      print ": "
      puts route
    end
    route_index = gets.chomp.to_i
    routes[route_index].add_station(new_station)
    routes[route_index].list_stations
  end

  if number == 5
    puts "Name station to delete"
    delete_station = gets.chomp
    station_to_delete = stations.find {|station| station.name == delete_station}
    puts "Choose route number"
    routes.each_with_index do |route, index|
      print index
      print ": "
      puts route
    end
    route_index = gets.chomp.to_i
    routes[route_index].remove_station(station_to_delete)
    routes[route_index].list_stations
  end

  if number == 6
    puts "Choose route number"
    routes.each_with_index do |route, index|
      print index
      print ": "
      puts route
    end
    route_index = gets.chomp.to_i
    puts "Enter train number"
    trains.each {|train| puts "#{train.number} : #{train}"}
    train_number = gets.chomp
    train = trains.find {|train| train.number == train_number}
    train.set_route(routes[route_index])
    puts "#{train.route}"
  end

  if number == 7
    puts "Select train number"
    trains.each {|train| puts "#{train.number} : #{train}"}
    puts "\n"
    train_number = gets.chomp
    train = trains.find {|train| train.number == train_number}
    if train.type == :cargo
      puts "\n" + "Specify capacity of a wagon"
      capacity = gets.chomp.to_i
      train.add_wagon(CargoWagon.new(train.type, capacity))
      puts "\n" + "Cargo wagon with capacity of #{capacity} added to Train #{train.number}"
      #puts "Cargo wagon #{CargoWagon.new(train.type, capacity)} added to Train #{train.number}"
    elsif train.type == :passenger
      puts "\n" + "Specify number of seats in a wagon"
      seats = gets.chomp.to_i
      train.add_wagon(PassengerWagon.new(train.type, seats))
      puts "\n" + "Passenger wagon with #{seats} seats added to Train #{train.number}"
    end
    puts train.wagons
  end

  if number == 8
    puts "Select train number"
    trains.each {|train| puts "#{train.number} : #{train}"}
    train_number = gets.chomp
    train = trains.find {|train| train.number == train_number}
    train.wagons.delete_at(-1)
    puts train.wagons
  end

  if number == 9
    puts "Select train number"
    trains.each {|train| puts "#{train.number} : #{train}"}
    train_number = gets.chomp
    train = trains.find {|train| train.number == train_number}
    train.forward
    puts train.current_station
  end

  if number == 10
    puts "Select train number"
    trains.each {|train| puts "#{train.number} : #{train}"}
    train_number = gets.chomp
    train = trains.find {|train| train.number == train_number}
    train.back
    puts train.current_station
  end

  if number == 11
    stations.each {|station| puts station}
  end

  if number == 12
    puts "Enter station"
    station_name = gets.chomp
    station = stations.find {|station| station.name == station_name}
    #station.list_trains
    if station.trains.empty? # if проверяет на true, a empty? возвращает true/false
      puts "you notice a group of strangers staring at you ༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽ seems like you did something not acceptable"
    else
      #station.list_trains
      station.count_trains_with_block { trains.each { |train| puts train} }
    end
  end

  if number == 13
    puts "\nEnter train number"
    trains.each {|train| puts "#{train.number} : #{train}"}
    train_number = gets.chomp
    train = trains.find {|train| train.number == train_number}
    puts "\n" + "Choose wagon"
    train.wagons.each_with_index do |wagon, index|
      print index
      print ": "
      puts wagon
    end
    wagon_index = gets.chomp.to_i
    if train.wagons[wagon_index].wagon_type == :cargo
      puts "\n" + "Enter loading weight"
      weight = gets.chomp.to_i
      train.wagons[wagon_index].cargo_load = weight
      puts "\n" + "Remaining capacity: #{train.wagons[wagon_index].remaining_load}"
    elsif train.wagons[wagon_index].wagon_type == :passenger
      train.wagons[wagon_index].book_seat
      puts "\n" + "Remaining seats: #{train.wagons[wagon_index].free_seats}"
    end
  end

  if number == 14
    puts "\n" + "Select train"
    trains.each_with_index do |train, index|
      print index
      print ": "
      puts train.number
    end
    train_index = gets.chomp.to_i
    puts "\n" + "Use SUPERPOWER?"
    answer_doesnt_matter = gets.chomp
    puts "\n" + "BLOKACHU I PICK YOU ϞϞ(๑⚈․⚈๑)∩"
    puts
    b = proc {|wagons| puts "#{wagons}"}
    trains[train_index].wagons_puts_with_block(&b)
    #trains[train_index]

  end
end
