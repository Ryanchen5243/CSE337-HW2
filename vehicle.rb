class Vehicle
  @@number_of_vehicles = 0
  def initialize(year, model, color)
    @@number_of_vehicles += 1
    @year = year
    @model = model
    @color = color
    @current_speed = 0
  end
  def speed_up(number)
    @current_speed += number
    return "You push the gas and accelerate #{number} mph."
  end
  def brake(number)
    @current_speed -= number
    return "You push the brake and decelerate #{number} mph."
  end
  def current_speed
    return "You are now going #{@current_speed} mph."
  end
  def spray_paint(given_color)
    @color = given_color
    return "Your new #{@color} paint job looks great!"
  end
  def self.gas_mileage(number1, number2)
    return "#{number2 / number1} miles per gallon of gas"
  end

  def self.number_of_vehicles
    @@number_of_vehicles
  end
end

module Towable
  def can_tow?(pounds)
    return pounds < 2000
  end
end

class MyCar < Vehicle
  NUMER_OF_DOORS = 4
  include Towable
  def initialize(year, model, color)
    super(year, model, color)
  end
  def to_s
    "My car is a #{@color}, #{@year}, #{@model}!"
  end
  def shut_down
    @current_speed = 0
    return "Let's park the car!"
  end
end

class MyTruck < Vehicle
  NUMER_OF_DOORS = 6
  include Towable
  def initialize(year, model, color)
    super(year, model, color)
  end
  def shut_down
    @current_speed = 0
    return "Let's park the Truck!"
  end
  def to_s
    "My truck is a #{@color}, #{@year}, #{@model}!"
  end
end
