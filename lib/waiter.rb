require 'pry'
class Waiter
  attr_accessor :name, :yrs_experience

  @@all = []

  def initialize(name, yrs_experience)
    @name = name
    @yrs_experience = yrs_experience
    self.class.all << self
  end

  def self.all
    @@all
  end

  def new_meal(customer, total, tip=0)
    Meal.new(self, customer, total, tip)
  end

  def meals
    Meal.all.select do |meal|
      meal.waiter == self
    end
  end

  def best_tipper
    best_tipped_meal = meals.max do |meal_a, meal_b|
      meal_a.tip <=> meal_b.tip
    end
    best_tipped_meal.customer
  end

  def most_freq_customer
    most_freq_customer_meal = meals.max_by{|meal| meals.count(meal)}
    most_freq_customer_meal.customer
  end

  def meal_of_worst_tipper
    meals.min do |meal_a, meal_b|
      meal_a.tip <=> meal_b.tip
    end
  end

  def self.tip_avg_lstexp_waiter
    lstexp_waiter = self.all.min{|waiter_a, waiter_b| waiter_a.yrs_experience <=> waiter_b.yrs_experience}
    tips_array = lstexp_waiter.meals.map{|meal| meal.tip}
    tips_array.sum(0.0)/tips_array.size
  end


end
