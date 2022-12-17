# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'validation'
require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'accessors'

# Test.attr_accessor_with_history('bb', 'cc', 'dd')
# a = Test.new
# a.bb = 5
# a.bb = 4
# a.bb = 3
# a.bb_history

# Test.strong_attr_accessor('vv', String)
# a.vv = 1 # F
# a.vv = 'a' # => 'a'
# a.vv # => 'a'

# q=Station.new('') # name can not be blank
# q=Station.new(1) # not a string
# q=Station.new('1') # invalid format
# q=Station.new('q') # ok
# q.valid? # true
# w=Station.new('we1') # ok
#
# z=Route.new('','') # first can not be blank
# z=Route.new('q','w') # first not a station
# z=Route.new(q,'') # last can not be blank #needs q=Station.new('q')
# z=Route.new(q,'w') # last not a station
# z=Route.new(q,w) # ok #needs w=Station.new('we1')
# z.valid? # true
#
# a=Train.new('', :cargo) # number can not be blank
# a=Train.new(1, :cargo) # number is not a string
# a=Train.new('a', :cargo) # number format invalid
# a=Train.new('123-ab', '') # type can not be blank
# a=Train.new('123-ab', 1) # type is not a symbol
# a=Train.new('123-ab', :a) # type format invalid
# a=Train.new('123-ab', :cargo) # ok
# a.valid? # true