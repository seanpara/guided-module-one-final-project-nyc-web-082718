class User < ActiveRecord::Base
    has_many :inventories
    has_many :foods, through: :inventories
    has_many :favorites
    has_many :meals, through: :favorites

    def eat_meal(meal)
      self.calories_consumed += meal.calories
    end

    def suggest_meal_by_time(time)
      Meal.select do |meal|
        meal.category.include?(time)
      end
    end

    def suggest_meal_by_macros(macro, amount)
      Meal.select do |meal|
        meal.nutrients[macro] >= amount
      end
    end

end
