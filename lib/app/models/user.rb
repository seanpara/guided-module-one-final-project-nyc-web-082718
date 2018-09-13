class User < ActiveRecord::Base
    has_many :inventories
    has_many :foods, through: :inventories
    has_many :favorites
    has_many :meals, through: :favorites

    def eat_meal(meal)
      prepare_meal(meal)
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

    def suggest_todays_meals
      times = ["breakfast","lunch","dinner"]
      meals = times.map do |time|
        suggest_meal_by_time(time).sample(1)[0]
      end
      total_calories = meals.inject(0){|sum, meal| sum + meal.calories }
      times.each_with_index do |time, index|
        puts "I've picked #{meals[index].name} for your #{time}"
      end
      puts "This amounts to #{total_calories} calories for the day."
      puts "Your daily calorie limit is #{self.calorie_limit} calories."
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
      self.kitchen.each do |item|
        meal.my_ingredients.each do |ingredient|
          if ingredient.food == item.food && item.quantity < ingredient.quantity
            puts "Sorry the meal cannot be prepared"
            break
          elsif ingredient.food == item.food && item.quantity >= ingredient.quantity
              new_quantity = item.quantity - ingredient.quantity
              item.update(quantity: new_quantity)
            break
          end
        end
      end

    end

    def kitchen
      Inventory.select { |item|  item.user == self }
    end

    # def available_meals
    #   # medium : I want to be able enter my name and check which types of meals are vailable based on my inventory
    #   #cross reference all meals against my kitchen
    #   Meal.all.my
    # end
    #
    # def neccessary_ingredients(meal)
    #   # medium: I want to be able to know which ingredients I'm missing in ordered to make a specified meal
    #   self.kitchen
    # end

    # hard: I want to be able to find all the recipes I am only missing one ingredient for
end
