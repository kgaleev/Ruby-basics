# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # $instances = 0
  # @instances = 0 # -- это инстанс переменная модуля, а не класса! Если бы она в классе объявлялась, то была бы инстанс переменной класса.
  # поэтому её там и надо объявлять

  module ClassMethods
    def instances
      # $instances
      @instances
    end
  end

  module InstanceMethods
    protected

    def register_instance
      @instances = 0
      self.class.instances += 1
      # puts self.class
      # @instances += 1
      # $instances += 1
    end
  end
end

# чтобы работал дебаг в модуле, нужно сюда накидать классы, инициализации и вызвать методы, а потом это всё проверять
