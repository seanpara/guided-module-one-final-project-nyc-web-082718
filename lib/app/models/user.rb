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

    def meal_request_based_on_calories(calorie_amount)
      #I want to be able to enter a calorie amount and get a list of meals that are under that calorie level
      meal_array = Meal.all.select {|meal| meal.calories < calorie_amount}
      meal_array.map { |meal| meal.name }
    end

    def add_meal_to_favorites(meal)
      #I want to be able to add a meal i like to my favorites list as well as remove them

      Favorite.create({user_id: self.id, meal_id: meal.id})
    end

    def delete_meal_from_favorites(meal)

      meal_to_delete = Favorite.find_by(meal_id: meal.id)
      meal_to_delete.destroy
    end

    def prepare_meal(meal)
      #  I should be able to prepare a meal and subtract the ingredients from my inventory
      #reduce the number of items in each user's inventory by the amount of each food in the meal
      Inventory.all.each do |item|
        if item.user == self && item.food == meal.food
          item.quantity - meal.food.quantity
        end
      end
    end

    def available_meals
      # medium : I want to be able enter my name and check which types of meals are vailable based on my inventory
      #cross reference all meals against my kitchen
    end

    def neccessary_ingredients(meal)
      # medium: I want to be able to know which ingredients I'm missing in ordered to make a specified meal
      self.kitchen
    end

    # hard: I want to be able to find all the recipes I am only missing one ingredient for
end
