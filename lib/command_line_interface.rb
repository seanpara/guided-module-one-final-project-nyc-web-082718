require_relative 'app/models/favorite.rb'
require_relative 'app/models/food.rb'
require_relative 'app/models/ingredient.rb'
require_relative 'app/models/inventory.rb'
require_relative 'app/models/meal.rb'
require_relative 'app/models/user.rb'
require_relative '../config/environment.rb'
require 'paint'

def welcome
  puts Paint[ "Welcome to the food recommendatron 3000.", :blue, :bright]
end

def identify
  puts Paint[ "Are you a new user or a returning user?", :green , :bright]
  puts Paint[ "Please answer 'new user' or 'returning user'", :green , :bright]
  new_or_not = gets.chomp
  until new_or_not == "new user" || new_or_not == "returning user"
    puts Paint[ "That is not a valid response. Please type 'new user' or 'returning user' exactly as shown.", :red , :bright]
    new_or_not = gets.chomp
  end
  # set_up_user(new_or_not)
  puts Paint[ "Checking user status...", :yellow , :bright]
  check_user_status(new_or_not)
end

def check_user_status(status)
  if status == "new user"
    puts Paint[ "Please enter your information.", :green , :bright]
    puts Paint[ "What is your name?", :green , :bright]
    name = gets.chomp
    puts Paint[ "What is your age?", :green , :bright]
    age = gets.chomp
    while !age.to_i.is_a? Integer
      puts Paint[ "Ages are usually represented by numbers. What is your age?", :red , :bright]
      age = gets.chomp
    end
    age = age.to_i
    puts Paint[ "How many calories do you want to eat in a day?", :green , :bright]
    calorie_limit = gets.chomp
    while calorie_limit.to_i == 0
      puts Paint[ "Calorie limits have to be expressed as numbers. What is your limit?", :red , :bright]
      calorie_limit = gets.chomp
    end
    calorie_limit = calorie_limit.to_i
    puts Paint[ "How many calories have you consumed so far?", :green , :bright]
    calories_so_far = gets.chomp
    puts Paint[ "Thanks! Setting you up now.", :yellow , :bright]
    user = User.create({name: name, age: age, calorie_limit: calorie_limit, calories_consumed: calories_so_far})
    puts Paint[ "Your account has been successfully created. Your user ID is #{user.id}. Please store it somewhere safe.", :blue , :bright]
    create_inventories(user)
  elsif status == "returning user"
    puts Paint[ "Please enter your User ID", :green , :bright]
    id = gets.chomp
    id = id.to_i
    while !id_valid?(id) || id == "new user"
      puts Paint[ "That is not a valid ID. Please enter a valid user ID, or enter 'new user' to set up a new account.", :red , :bright]
      id = gets.chomp
      id = id.to_i
    end
    if id == "new user"
      user = new_user
    else
      user = User.find_by(id: id)
      puts Paint[ "Welcome back, #{user.name}!", :blue , :bright]
      puts Paint[ "How many calories have you consumed so far today?", :green , :bright]
      new_calories = gets.chomp
      user.update(calories_consumed: new_calories)
    end
    user
  end
end

def new_user
  puts Paint[ "Please enter your information.", :green , :bright]
  puts Paint[ "What is your name?", :green , :bright]
  name = gets.chomp
  puts Paint[ "What is your age?", :green , :bright]
  age = gets.chomp
  while !age.to_i.is_a? Integer
    puts Paint[ "Ages are usually represented by numbers. What is your age?", :red , :bright]
    age = gets.chomp
  end
  age = age.to_i
  puts Paint[ "How many calories do you want to eat in a day?", :green , :bright]
  calorie_limit = gets.chomp
  while !calorie_limit.to_i.is_a? Integer && calorie_limit != 0
    puts Paint[ "Calorie limits have to be expressed as numbers. What is your limit?", :red , :bright]
    calorie_limit = gets.chomp
  end
  calorie_limit = calorie_limit.to_i
  puts Paint[ "How many calories have you consumed so far?", :green , :bright]
  calories_so_far = gets.chomp
  puts Paint[ "Thanks! Setting you up now.", :yellow , :bright]
  user = User.create({name: name, age: age, calore_limit: calorie_limit, calories_consumed: calories_so_far})
  puts Paint[ "Your account has been successfully created. Your user ID is #{user.id}. Please store it somewhere safe.", :blue , :bright]
  create_inventories(new_user)
  new_user
end

# def set_up_user(new_or_not)
#   binding.pry
#   if new_or_not == "returning user"
#     puts Paint[ "please enter your old ID"
#     id = gets.chomp
#     id_valid?(id)
#     puts Paint[ "Welcome back #{user.name}".
#   elsif new_or_not == "new user"
#     binding.pry
#     user = User.create
#     puts Paint[ "Please enter your information."
#     get_new_user_info(user)
#     puts Paint[ "Your account has been successfully created. Your user ID is #{user.id}. Please store it somewhere safe."
#     create_inventories(user)
#   end
# end

def id_valid?(id)
  User.all.find_by(id: id) != nil
end

# def id_valid?(id)
#   result = User.all.find { |user| user.id == id }
#   if result == nil
#     puts Paint[ "No user with that ID has been found. Start over and create a new account or enter a real ID dummy."
#     input = gets.chomp
#     id_valid?(input.to_i)
#   else
#     puts Paint[ "ID has been approved."
#     true
#   end
# end

# def get_new_user_info(user)
#   puts Paint[ "What is your name?"
#   name = gets.chomp
#   user.name = name
#   puts Paint[ "What is your age?"
#   age = gets.chomp
#   user.age = age
#   puts Paint[ "What is your daily calorie_limit?"
#   calorie_limit = gets.chomp
#   user.calorie_limit = calorie_limit
# end

def create_inventories(user)
  Food.all.each_with_index do |food, index|
    puts Paint[ "How many #{food.name} do you have?", :green , :bright]
    quantity = gets.chomp
    until quantity.to_i.class == Fixnum
      puts Paint[ "Please enter a real number.", :red , :bright]
    end
    Inventory.create({user: user, food: food, quantity: quantity})
    # binding.pry
  end
  user
end

def topic?(user)
  puts Paint[ "What do you want to do?", :blue , :bright]
  puts Paint[ "To update account type 'account'", :green , :bright]
  puts Paint[ "For options about foods type 'foods'", :green , :bright]
  puts Paint[ "For options about meals type 'meals'"
  puts Paint[ "For options about favorites type 'favorites'", :green , :bright]
  puts Paint[ "For options about inventory type 'inventory'", :green , :bright]

  answer = gets.chomp
  case answer
  when "account"
    puts Paint[ "What would you like to update?", :blue , :bright]
    puts Paint[ "name", :green , :bright]
    puts Paint[ "age", :green , :bright]
    puts Paint[ "calorie_limit", :green , :bright]
    puts Paint[ "calories_consumed", :green , :bright]
    puts Paint[ "delete", :red , :bright]
    desired_update = gets.chomp
    case desired_update
    when "name"
      puts Paint[ "What would you like to change your #{desired_update} to?", :green , :bright]
      name = gets.chomp
      # binding.pry
      user.name = name
    when "age"
      puts Paint[ "What would you like to change your #{desired_update} to?", :green , :bright]
      age = gets.chomp
      user.age = age
    when "calorie_limit"
      puts Paint[ "What would you like to change your #{desired_update} to?", :green , :bright]
      calorie_limit = gets.chomp
      user.calorie_limit = calorie_limit
    when "calories_consumed"
      puts Paint[ "What would you like to change your #{desired_update} to?", :green , :bright]
      calories_consumed = gets.chomp
      user.calories_consumed = calories_consumed
    when "delete"
      puts Paint[ "Are you sure you want to delete your account permanently? Enter 'yes' if so.", :red , :bright]
      answer = gets.chomp
      if answer.downcase == "yes"
        user_to_delete = User.find_by(id: user.id)
        user_to_delete.destroy
      end
    end
  when "foods"
    puts Paint[ "What do you want to do?", :green , :bright]
    puts Paint[ "To ask for a list of all available foods type 'list'.", :green , :bright]
    puts Paint[ "To ask about a food type 'ask'.", :green , :bright]
    puts Paint[ "What food do you want to ask about?", :green , :bright]
    input = gets.chomp
    case input
    when "ask"
      food = gets.chomp
      possible_foods = Food.all.map { |food_object| food_object.name }
      until possible_foods.include?(food)
        puts Paint[ "Please select a real food.", :red , :bright]
        food = gets.chomp
      end

      puts Paint[ "What information would you like to know about #{food}?", :green , :bright]
      desired_info = gets.chomp
      possible_info = Food.column_names
      until possible_info.include?(desired_info)
        puts Paint[ "Please ask for legitimate information.", :red , :bright]
        desired_info = gets.chomp
      end
      actual_food = Food.all.find(food) { |food_object| food_object.name == food}
      puts Paint[ actual_food.send("#{desired_info}") , :green , :bright]

    when "list"
      puts Paint[ "Here are all the available foods:", :green , :bright]
      Food.all.each do |food|
        puts Paint[ food.name , :green , :bright]
      end
    end

  when "meals"
    puts Paint[ "To ask about a meal type 'ask meal'", :green , :bright]
    puts Paint[ "To list all available meals type 'list'", :green , :bright]
    puts Paint[ "To update a meal type 'update'", :green , :bright]
    puts Paint[ "To create a meal type 'create'", :green , :bright]
    puts Paint[ "To delete a meal type 'delete'", :red , :bright]
    puts Paint[ "For a meal recommendation type 'recommend meal'.", :green , :bright]
    puts Paint[ "For an entire day's course recommendation type 'recommend , :green , :bright]course'.", :green , :bright]
    puts Paint[ "To prepare a meal and eat type 'prepare meal'", :green , :bright]
    input = gets.chomp
    case input
    when "ask meal"
      puts Paint[ "What meal do you want to ask about?", :green , :bright]
      meal = gets.chomp
      possible_meals = Meal.all.map { |meal_object| meal_object.name }
      until possible_meals.include?(meal)
        puts Paint[ "Please select a real meal.", :red , :bright]
        meal = gets.chomp
      end

      puts Paint[ "What information would you like to know about #{meal}?", :green , :bright]
      desired_info = gets.chomp
      possible_info = Food.column_names
      until possible_info.include?(desired_info)
        puts Paint[ "Please ask for legitimate information.", :red , :bright]
        desired_info = gets.chomp
      end
      # binding.pry
      actual_meal = Meal.all.find(meal) { |meal_object| meal_object.name == meal}
      # binding.pry
      puts Paint[ actual_meal.send("#{desired_info}"), :green , :bright]
    when "list"
      puts Paint[ "Here are all the available meals:", :green , :bright]
      Meal.all.each do |meal|
        puts Paint[ meal.name, :green , :bright]
      end
    when "update"
      puts Paint[ "Which meal would you like to update?", :green , :bright]
      meal = gets.chomp
      actual_meal = Meal.all.find(meal) { |meal_object| meal_object.name == meal}
      puts Paint[ "What would you like to change?"
      puts Paint[ "To change name 'name'"
      puts Paint[ "To change category puts Paint[ 'category'"
      desired_update = gets.chomp
      case desired_update
      when "name"
        puts Paint[ "What would you like to rename this meal?"
        new_name = gets.chomp
        actual_meal.update(name: new_name)
      when "category"
        puts Paint[ "What would you like to change this meal's categories to?"
        puts Paint[ "Enter them in one line in lower case with spaces"
        puts Paint[ "ie: 'breakfast dinner'"
        new_categories = gets.chomp
        actual_meal.update(category: new_categories)
      end
    when "create"
      puts Paint[ "What would you like to name this meal?"
      name = gets.chomp
      puts Paint[ "What are this meal's categories?"
      puts Paint[ "Enter them in one line in lower case with spaces"
      puts Paint[ "ie: 'breakfast dinner'"
      categories = gets.chomp
      Meal.create({name: name, category: categories})
    when "delete"
      puts Paint[ "Please enter the name of the meal you want to delete."
      meal = gets.chomp
      actual_meal = Meal.all.find{ |meal_object| meal_object.name == meal}
      puts Paint[ "Are you sure you want to delete #{actual_meal.name} permanently? Enter 'yes' if so."
      answer = gets.chomp
      if answer.downcase == "yes"
        deleted_name = actual_meal.name
        #meal_to_delete = Meal.find_by(id: actual_meal.id)
        actual_meal.destroy
        puts Paint[ "#{deleted_name} has been removed from the database."
      end
    when "recommend meal"
      puts Paint[ "Would condition would you like your recommendation by?"
      puts Paint[ "time"
      puts Paint[ "macros"
      puts Paint[ "calories"
      recommendation_choice = gets.chomp
      case recommendation_choice
      when "time"
        puts Paint[ "Input a time."
        time = gets.chomp
        user.suggest_meal_by_time(time)
      when "macros"
        puts Paint[ "Input a macro."
        macro = gets.chomp
        puts Paint[ "Input an amount."
        amount = gets.chomp
        user.suggest_meal_by_macros(macro, amount.to_i)
      when "calories"
        puts Paint[ "Input a calorie amount."
        calorie_amount = gets.chomp
        user.meal_request_based_on_calories(calorie_amount)
      else
        puts Paint[ "Please enter a valid condition."
      end

    when "recommend course"
      user.suggest_todays_meals

    when "prepare meal"
      puts Paint[ "What meal would you like to prepare?"
      meal = gets.chomp
      actual_meal = Meal.all.find(meal) { |meal_object| meal_object.name == meal}
      # binding.pry
      user.prepare_meal(actual_meal)
      puts Paint[ "Your meal is prepared."
      # binding.pry
      user.eat_meal(actual_meal)
      puts Paint[ "That was delcious!"
    end
  when "favorites"
    puts Paint[ "To check your list of favorite meals type 'check favorites'"
    puts Paint[ "To add a meal to your favorites type 'add favorite'"
    puts Paint[ "To remove a meal from your favorites type 'remove favorite'"
    input = gets.chomp
    case input
    when "check favorites"
      puts Paint[ "Here are all your favorite meals:"
      # binding.pry
      Favorite.all.select{|favorite| favorite.user == user}.each do |favorite|
        puts Paint[ favorite.meal.name
    #  user.favorites.each do |favorite|
        # binding.pry
      #  puts Paint[ favorite.meal.name
      end
    when "add favorite"
      puts Paint[ "What meal would you like to add?"
      meal = gets.chomp
      actual_meal = Meal.all.find { |meal_object| meal_object.name == meal}
      actual_favorite = Favorite.all.find { |favorite| favorite.meal == actual_meal && favorite.user == user}
      # user.add_meal_to_favorites(actual_meal)
      binding.pry
      user.add_meal_to_favorites(actual_meal)
    when "remove favorite"
      puts Paint[ "What meal would you like to remove?"
      meal = gets.chomp
      actual_meal = Meal.all.find { |meal_object| meal_object.name == meal}
      user.delete_meal_from_favorites(actual_meal)
    end
  when "inventory"
    puts Paint[ "To check your inventory type 'check inventory'"
    puts Paint[ "To add an item to your inventory type 'add inventory'"
    input = gets.chomp
    case input
    when "check inventory"
      puts Paint[ "Here are all of the items in your inventory:"
      user.kitchen.each do |inventory|
        puts Paint[ "#{inventory.food.name}:#{inventory.quantity} "
      end
    when "add inventory"
      puts Paint[ "What item would you like to add?"
      food = gets.chomp
      puts Paint[ "How many would you like to add?"
      amount = gets.chomp.to_i
      # binding.pry
      actual_food = Food.all.find { |food_object| food_object.name == food}
      actual_inventory = Inventory.all.find { |inventory| inventory.food == actual_food && inventory.user == user}
      new_number = actual_inventory.quantity + amount
      actual_inventory.update(quantity: new_number)
    end
  else
    puts Paint[ "Please put a legitimate choice."
  end
end


def meal_recommendation(user)
  puts Paint[ "How do you want to pick a meal?"
  puts Paint[ "Please select 'calories','macros', or 'meal time'"
  selection = gets.chomp

  until ['calories','macros','meal time'].include?(selection) do
    puts Paint[ "I can't recommend a meal based on that. Please select from 'calories', 'macros', or 'meal time'"
    selection = gets.chomp
  end

  #meal rec based on calories
  if selection == 'calories'
    puts Paint[ "What is the calorie limit for this meal?"
    limit = gets.chomp.to_i
    until limit.is_a? Integer
      puts Paint[ "I need a number to recommend based on calories. Please enter the calorie limit for this meal."
      limit = gets.chomp
    end
    meal_options = user.meal_request_based_on_calories(limit)
    puts Paint[ "I can recommend the following meals to you:"
    meal_options.map do |option|
      puts Paint[ "#{option.name}, a #{option.what_category?} meal with #{option.calories} calories"
    end
    #meal rec based on macros
  elsif selection == 'macros'
    puts Paint[ "Which macro would you like to specify: protein, fats, or carbohydrates?"
    macro = gets.chomp
    until ['protein','fats','carbohydrates'].include?(macro) do
      puts Paint[ "That's not a valid macro. Please pick from protein, fats, or carbohydrates."
      macro = gets.chomp
    end
    puts Paint[ "How many grams of #{macro} are you looking for?"
    amount = gets.chomp.to_i
    until amount.is_a? Integer do
      puts Paint[ "I need a number amount of #{macro} to make a recommendation. How many grams would you like?"
      amount = gets.chomp.to_i
    end
    meal_options = user.suggest_meal_by_macros(macro,amount)
    puts Paint[ "I can recommend the following meals to you:"
    meal_options.map do |option|
      puts Paint[ "#{option.name}, a #{option.calories}-calorie #{option.what_category?} meal with:"
      option.nutrients.each do |nutrient,amount|
        puts Paint[ "#{amount} grams of #{nutrient}"
        puts Paint[ "="*25
      end
    end
    #meal rec based on meal time
  elsif selection == 'meal time'
    puts Paint[ "Which meal time do you want a suggestion for? Choose breakfast, lunch, or dinner"
    meal_time = gets.chomp
    until ["breakfast","lunch","dinner"].include?(meal_time) do
      puts Paint[ "That wasn't a valid selection. Choose breakfast, lunch, or dinner"
      meal_time = gets.chomp
    end
    meal_options = user.suggest_meal_by_time(meal_time)
    puts Paint[ "I can recommend the following meals to you:"
    meal_options.map do |option|
      "#{option.name}"
    end
  end
end

def continue_or_quit?(user)
  input = "yes"
  while input == "yes"
    puts Paint[ "Do you want to do something else?"
    input = gets.chomp
    if input == "yes"
      topic?(user)
    else
      print "Thanks #{user.name}! Don't forget, your user ID is #{user.id}!"
      print "Enjoy your meals!"
    end
  end
end

def run_command_line_interface
  welcome
  user = identify
  topic?(user)
  continue_or_quit?(user)
end
