require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'passenger_train'
require_relative 'cargo_train'

#p=Wagon.new(:cargo)
#p.assign_company('wheels')
#p.company
#q=Station.new('q')
#w=Station.new('w')
#Station.all
#Train.find(1)
#Train.find(50)
#d=CargoTrain.new(3)
#f=CargoTrain.new(4)
#g=PassengerTrain.new(5)
#z=Route.new(q,w)
#x=Route.new(q,w)
#Station.instances
#Train.instances
#CargoTrain.instances
#PassengerTrain.instances
#Route.instances

#will not work because private
#a=Train.new(1,:cargo)
#s=Train.new(2,:passenger)


# Создать модуль, который позволит указывать название компании-производителя и получать его. Подключить модуль к классам Вагон и Поезд
# В классе Station (жд станция) создать метод класса all, который возвращает все станции (объекты), созданные на данный момент
# Добавить к поезду атрибут Номер (произвольная строка), если его еще нет, который указыватеся при его создании
# В классе Train создать метод класса find, который принимает номер поезда (указанный при его создании) и возвращает объект поезда по номеру или nil, если поезд с таким номером не найден.
# Создать модуль InstanceCounter, содержащий следующие методы класса и инстанс-методы, которые подключаются автоматически при вызове include в классе:
# Методы класса:
#        - instances, который возвращает кол-во экземпляров данного класса
# Инстанс-методы:
#        - register_instance, который увеличивает счетчик кол-ва экземпляров класса и который можно вызвать из конструктора. При этом данный метод не должен быть публичным.
# Подключить этот модуль в классы поезда, маршрута и станции.
# Примечание: инстансы подклассов могут считаться по отдельности, не увеличивая счетчик инстансов базового класса.
