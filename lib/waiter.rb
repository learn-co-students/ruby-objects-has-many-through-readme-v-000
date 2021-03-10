require 'pry'
class Waiter
  @@all = []
  attr_accessor :name, :experience
  
  def initialize(name, experience)
    @name = name
    @experience = experience
    @@all << self
  end
  
  def self.all 
    @@all
  end
  
  def new_meal(customer, total, tip)
    Meal.new(self, customer, total, tip)
  end
  
  def meals
    Meal.all.select{|meal| meal.waiter == self}
  end
  
  def best_tipper 
    waiter_meals = []
    Meal.all.each do |meal| 
      if meal.waiter == self
        waiter_meals << meal
      end
    end
    waiter_meals.sort_by! {|meal| meal.tip}
    waiter_meals.last.customer
  end
end