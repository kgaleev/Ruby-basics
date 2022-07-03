# frozen_string_literal: true

class CargoWagon < Wagon
  public_class_method :new

  # Добавить атрибут общего объема (задается при создании вагона)
  def initialize(type = :cargo, total_space)
    # super(type) - указать в скобках, если надо конкретный параметр от родителя, а не все
    super(type, total_space)
    # @capacity = capacity
    # @current_load = 0
  end

  # Добавить метод, который "занимает объем" в вагоне (объем указывается в качестве параметра метода)
  def cargo_load=(cargo_load)
    # @cargo_load = cargo_load
    # if @capacity >= @current_load + cargo_load
    # if self.capacity >= @current_load + cargo_load
    if total_space >= @occupied_space + cargo_load
      @occupied_space += cargo_load
    else
      puts '(っ—●-益—●-) !!已超过中国边境可能运输的货物数量!!'
    end
  end

  # Добавить метод, который возвращает занятый объем
  attr_reader :total_space, :occupied_space # :current_load, :capacity

  # Добавить метод, который возвращает оставшийся (доступный) объем
  # def remaining_load
  #   self.capacity - self.current_load
  # end
end
