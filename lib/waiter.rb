class Waiter
  
  attr_accessor :name, :years
  
  @@all = []
  
  def initialize(name, years)
    @name = name
    @years = years
    @@all << self
  end
  
  def self.all
    @@all
  end
  
  def new_meal(customer, total, tip)
    Meal.new(self, customer, total, tip)
  end
  
  def meals
    Meal.all.select { |m| m.waiter == self }
  end
  
  def best_tipper
    best_tip = 0
    best_cust = nil
    Meal.all.each do |m|
      if m.tip > best_tip
        best_tip = m.tip
        best_cust = m.customer
      end
    end
    best_cust
  end
end