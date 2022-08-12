# frozen_string_literal: true

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
require_relative 'accessors'

class Test
  extend Accessors

  attr_accessor_with_history :my_attr, :a, :b, :c
end

# m = Test.new
# Test.attr_accessor_with_history('be')
# m.be = 5
# m.be +=1
# Test.attr_accessor_with_history('be1', 'ce1', 'de1')

# q=Station.new('q')
# w=Station.new('w')
# d=CargoTrain.new("122ab")
# z=Route.new(q,w)
# d.route=(z)
# p=CargoWagon.new(2)
# d.add_wagon(p)

# q.arrival(d)
# p=Wagon.new(:cargo, 15)
# p.assign_company('wheels')
# p.company
# Station.all
# d=CargoTrain.new(3)
# d=CargoTrain.new("122ab")
# f=CargoTrain.new("tyz-88")
# Train.find(3)
# Train.find("122ab")
# g=PassengerTrain.new("abc-22")
# z=Route.new(q,w)
# z=Route.new('q','w')
# x=Route.new(q,w)
# Station.instances
# Train.instances
# CargoTrain.instances
# PassengerTrain.instances
# Route.instances

# will not work because private
# a=Train.new(1,:cargo)
# s=Train.new(2,:passenger)
