
module Validation

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods #extend
  # def validate(atr_name, type, *args)
    def validate(val_name, val_type, val_param = nil) # possible to input 3 args, but only 2 required at minimum
      @validations ||= []
      #binding.irb
      @validations << { # through hash it's easier; put hash into array
                        val_name: val_name,
                        val_type: val_type,
                        val_param: val_param
      }.compact # nil values/key pairs removed
      nil # do not return hash
    end
  end

  module InstanceMethods #include
    ValidationError = Class.new(StandardError)

    def perform_validation
      self.class.instance_variable_get(:@validations).each do |val_hash|
        value = instance_variable_get(:"@#{val_hash[:val_name]}")

        case val_hash[:val_type]
        when :presence
          return "#{val_hash[:val_name]} can not be blank" if value.to_s.length.zero?
        when :format
          return "#{val_hash[:val_name]} format is not valid" unless val_hash[:val_param] =~ value.to_s
        when :type
          return "#{val_hash[:val_name]} is not a #{val_hash[:val_param]}" unless value.is_a?(val_hash[:val_param])
          #return "#{val_hash[:val_name]} is not a #{value.is_a?(val_hash[:val_param])}" unless value.is_a?(val_hash[:val_param])
          #return "#{val_hash[:val_name]} is not a #{val_hash[:val_name].class}" unless value.is_a?(val_hash[:val_param])
          #else raise TypeError, "#{val_type}  может быть только :presence, :format или :type" unless %i[presence format type].include?(type)
        end
      end
      nil # each returns a value (array @validations), it will trigger {if} in {validate!}
    end

    def validate!
      error = perform_validation
      # if error # if truthy (not nil and not false)
      # raise ValidationError, error
      raise ValidationError, error if error
        # if object contains string, it can be passed to raise
    end

    def valid?
      validate!
      true
    rescue ValidationError
      false
    end

  end
end

class Post
  include Validation

  attr_accessor :title, :number

  validate :title, :presence
  validate :title, :type, String
  #  validate :number, :type, Integer
  #  validate :number, :format, /0/
end

# class Train
#   include Validation
#
#   attr_accessor :number, :type
#
#   validate :number, :presence
#   validate :number, :type, Integer
#   validate :type, :format, /cargo|passenger/
#
#   def initialize(number, type: "cargo")
#     @number = number
#     @type = type
#
#     validate!
#   end
# end

p = Post.new
#p.title = "title"
#p.number = 0
# p.valid?
# p.validate!

#p.number = 123
puts p.valid?
#p.validate!