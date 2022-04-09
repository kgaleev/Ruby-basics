module InstanceCounter

  def self.instances
    @@instances
  end

  protected

  def register_instance
    @@instances +=1
  end
end