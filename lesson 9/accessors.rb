
module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_name_history = "@#{name}_history".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        if instance_variable_get(var_name) == nil
          instance_variable_set(var_name_history, [] )
        else
          history = instance_variable_get(var_name)
          instance_variable_get(var_name_history) << history
        end
        instance_variable_set(var_name, value)
      end

      define_method("#{name}_history".to_sym) { instance_variable_get(var_name_history) }
    end
  end
end

class Test
  extend Accessors
end