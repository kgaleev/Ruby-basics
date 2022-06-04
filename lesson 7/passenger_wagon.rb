class PassengerWagon < Wagon

  public_class_method :new

  #Добавить атрибут общего кол-ва мест (задается при создании вагона)
  def initialize(type = :passenger, total_space)
    super(type, total_space)
    #@seats = seats
    #@booked_seats = 0
  end

  #Добавить метод, который "занимает места" в вагоне (по одному за раз)
  def book_seat
    if @total_space > @occupied_space
      @occupied_space +=1
    end
  end

  #Добавить метод, который возвращает кол-во занятых мест в вагоне
  attr_reader :occupied_space #:booked_seats

  #Добавить метод, возвращающий кол-во свободных мест в вагоне.
  # def free_seats
  #   @seats - @booked_seats
  # end

end
