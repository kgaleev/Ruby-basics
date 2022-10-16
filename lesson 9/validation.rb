
module Validation

  module ClassMethods #extend
  # def validate(atr_name, type, *args)
    def validate(val_name, val_type, val_arg = nil) #possible to input 3 args, but only 2 required at minimum
      @rules ||= []
      @rules << { # through hashes it's is easier
        val_name: val_name,
        val_type: val_type,
        val_arg: val_arg
      }.compact # nil values/key pairs removed
      nil # do not return hash
    end
  end

  module InstanceMethods #include
    ValidationError = Class.new(StandardError)

    def perform_validation
      self.class.instance_variable_get(:@rules).each do |val_type|
        value = instance_variable_get(:"@#{val_type[:val_arg]}")

        case val_type[:val_type]
        when :presence
          return "#{rule[:attribute]} can not be blank" if value.to_s.length.zero?
        when :type
          return "#{rule[:attribute]} is not a" unless value.is_a?(rule[:options])
        when :format
          return "#{rule[:attribute]} format is invalid" unless rule[:options] =~ value.to_s
          #else raise TypeError, "#{val_type}  может быть только :presence, :format или :type" unless %i[presence format type].include?(type)
        end
      end
      nil # each returns a value. I don't need that
    end

    def validate!
      error = perform_validation
      raise ValidationError, error if error
    end

    def valid?
      validate!
      true
    rescue ValidationError
      false
    end
  end
end