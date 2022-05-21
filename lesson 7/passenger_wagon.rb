class PassengerWagon < Wagon

  public_class_method :new

  #Добавить атрибут общего кол-ва мест (задается при создании вагона)
  def initialize(type = :passenger, seats)
    super(type)
    @seats = seats
    @booked_seats = 0
  end

  #Добавить метод, который "занимает места" в вагоне (по одному за раз)
  def book_seat
    if @seats > @booked_seats
      @booked_seats +=1
    end
  end

  #Добавить метод, который возвращает кол-во занятых мест в вагоне
  attr_reader :booked_seats

  #Добавить метод, возвращающий кол-во свободных мест в вагоне.
  def free_seats
    @seats - @booked_seats
  end

end
