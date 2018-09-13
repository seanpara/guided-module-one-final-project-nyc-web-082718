require_relative 'app/models/favorite.rb'
require_relative 'app/models/food.rb'
require_relative 'app/models/ingredient.rb'
require_relative 'app/models/inventory.rb'
require_relative 'app/models/meal.rb'
require_relative 'app/models/user.rb'
require_relative '../config/environment.rb'

def welcome
  puts "Welcome to the food recommendatron 3000."
end

def identify
  puts "Are you a new user or a returning user?"
  puts "Please answer 'new user' or 'returning user'"
  new_or_not = gets.chomp
  until new_or_not == "new user" || new_or_not == "returning user"
    puts "That is not a valid response. Please type 'new user' or 'returning user' exactly as shown."
    new_or_not = gets.chomp
  end
  # set_up_user(new_or_not)
  puts "Checking user status..."
  check_user_status(new_or_not)
end

def check_user_status(status)
  if status == "new user"
    puts "Please enter your information."
    puts "What is your name?"
    name = gets.chomp
    puts "What is your age?"
    age = gets.chomp
    while !age.to_i.is_a? Integer
      puts "Ages are usually represented by numbers. What is your age?"
      age = gets.chomp
    end
    age = age.to_i
    puts "How many calories do you want to eat in a day?"
    calorie_limit = gets.chomp
    while calorie_limit.to_i == 0
      puts "Calorie limits have to be expressed as numbers. What is your limit?"
      calorie_limit = gets.chomp
    end
    calorie_limit = calorie_limit.to_i
    puts "Thanks! Setting you up now."
    User.create({name: name, age: age, calorie_limit: calorie_limit})
  elsif status == "returning user"
    puts "Please enter your User ID"
    id = gets.chomp
    id = id.to_i
    while !id_valid?(id) || id == "new user"
      puts "That is not a valid ID. Please enter a valid user ID, or enter 'new user' to set up a new account."
      id = gets.chomp
      id = id.to_i
    end
    if id == "new user"
      new_user
    else
      puts "Welcome back, #{User.find_by(id: id).name}!"
    end
  end
end

def new_user
  puts "Please enter your information."
  puts "What is your name?"
  name = gets.chomp
  puts "What is your age?"
  age = gets.chomp
  while !age.to_i.is_a? Integer
    puts "Ages are usually represented by numbers. What is your age?"
    age = gets.chomp
  end
  age = age.to_i
  puts "How many calories do you want to eat in a day?"
  calorie_limit = gets.chomp
  while !calorie_limit.to_i.is_a? Integer && calorie_limit != 0
    puts "Calorie limits have to be expressed as numbers. What is your limit?"
    calorie_limit = gets.chomp
  end
  calorie_limit = calorie_limit.to_i
  puts "Thanks! Setting you up now."
  new_user = User.create({name: name, age: age, calore_limit: calorie_limit})
  puts "Your account has been successfully created. Your user ID is #{new_user.id}. Please store it somewhere safe."
end

# def set_up_user(new_or_not)
#   binding.pry
#   if new_or_not == "returning user"
#     puts "please enter your old ID"
#     id = gets.chomp
#     id_valid?(id)
#     puts "Welcome back #{user.name}".
#   elsif new_or_not == "new user"
#     binding.pry
#     user = User.create
#     puts "Please enter your information."
#     get_new_user_info(user)
#     puts "Your account has been successfully created. Your user ID is #{user.id}. Please store it somewhere safe."
#     create_inventories(user)
#   end
# end

def id_valid?(id)
  User.all.find_by(id: id) != nil
end

# def id_valid?(id)
#   result = User.all.find { |user| user.id == id }
#   if result == nil
#     puts "No user with that ID has been found. Start over and create a new account or enter a real ID dummy."
#     input = gets.chomp
#     id_valid?(input.to_i)
#   else
#     puts "ID has been approved."
#     true
#   end
# end

def get_new_user_info(user)
  puts "What is your name?"
  name = gets.chomp
  user.name = name
  puts "What is your age?"
  age = gets.chomp
  user.age = age
  puts "What is your daily calorie_limit?"
  calorie_limit = gets.chomp
  user.calorie_limit = calorie_limit
end

def create_inventories(user)
  Food.all.each_with_index do |food, index|
    puts "How many #{food.name} do you have?"
    quantity = gets.chomp
    until quantity.class = Fixnum
      puts "Please enter a real number."
    end
    Inventory.create({user: user, food: food, quantity: quantity})
  end
end

def topic?
  puts "What do you want to do?"
  puts "To ask about a food type 'food'."
  puts "To ask about a meal type 'meal'."
  puts "For a meal recommendation type 'recommend meal'."
  puts "For an entire day's course recommendation type 'recommend course'."
  answer = gets.chomp
  case answer
  when "food"
    puts "What food do you want to ask about?"
    food = gets.chomp
    possible_foods = Food.all.map { |food_object| food_object.name }
    until possible_foods.include?(food)
      puts "Please select a real food."
      food = gets.chomp
    end

    puts "What information would you like to know about #{food}?"
    desired_info = gets.chomp
    possible_info = Food.column_names
    until possible_info.include?(desired_info)
      puts "Please ask for legitimate information."
      desired_info = gets.chomp
    end
    actual_food = Food.all.find(food) { |food_object| food_object.name == food}
    puts actual_food.send("#{desired_info}")

  when "meal"
    puts "What meal do you want to ask about?"
    meal = gets.chomp
    possible_meals = Meal.all.map { |meal_object| meal_object.name }
    until possible_meals.include?(meal)
      puts "Please select a real meal."
      meal = gets.chomp
    end

    puts "What information would you like to know about #{meal}?"
    desired_info = gets.chomp
    possible_info = Food.column_names
    until possible_info.include?(desired_info)
      puts "Please ask for legitimate information."
      desired_info = gets.chomp
    end
    # binding.pry
    actual_meal = Meal.all.find(meal) { |meal_object| meal_object.name == meal}
    # binding.pry
    puts actual_meal.send("#{desired_info}")

  when "recommend meal"
    puts "Would condition would you like your recommendation by?"
    puts "time"
    puts "macros"
    puts "calories"
    recommendation_choice = gets.chomp
    case recommendation_choice
    when "time"
      puts "Input a time."
      time = gets.chomp
      user.suggest_meal_by_time(time)
    when "macros"
      puts "Input a macro."
      macro = gets.chomp
      puts "Input an amount."
      amount = gets.chomp
      user.suggest_meal_by_macros(macro, amount)
    when "calories"
      puts "Input a calorie amount."
      calorie_amount = gets.chomp
      user.meal_request_based_on_calories(calorie_amount)
    else
      puts "Please enter a valid condition."
    end
  when "recommend course"
    meal_recommendation(user)
  else
    puts "Please put a legitimate choice."
  end
end


def meal_recommendation(user)
  puts "How do you want to pick a meal?"
  puts "Please select 'calories','macros', or 'meal time'"
  selection = gets.chomp

  until ['calories','macros','meal time'].include?(selection) do
    puts "I can't recommend a meal based on that. Please select from 'calories', 'macros', or 'meal time'"
    selection = gets.chomp
  end

  #meal rec based on calories
  if selection == 'calories'
    puts "What is the calorie limit for this meal?"
    limit = gets.chomp.to_i
    until limit.is_a? Integer
      puts "I need a number to recommend based on calories. Please enter the calorie limit for this meal."
      limit = gets.chomp
    end
    meal_options = user.meal_request_based_on_calories(limit)
    puts "I can recommend the following meals to you:"
    meal_options.map do |option|
      puts "#{option.name}, a #{option.what_category?} meal with #{option.calories} calories"
    end
    #meal rec based on macros
  elsif selection == 'macros'
    puts "Which macro would you like to specify: protein, fats, or carbohydrates?"
    macro = gets.chomp
    until ['protein','fats','carbohydrates'].include?(macro) do
      puts "That's not a valid macro. Please pick from protein, fats, or carbohydrates."
      macro = gets.chomp
    end
    puts "How many grams of #{macro} are you looking for?"
    amount = gets.chomp.to_i
    until amount.is_a? Integer do
      puts "I need a number amount of #{macro} to make a recommendation. How many grams would you like?"
      amount = gets.chomp.to_i
    end
    meal_options = user.suggest_meal_by_macros(macro,amount)
    puts "I can recommend the following meals to you:"
    meal_options.map do |option|
      puts "#{option.name}, a #{option.calories}-calorie #{option.what_category?} meal with:"
      option.nutrients.each do |nutrient,amount|
        puts "#{amount} grams of #{nutrient}"
        puts "="*25
      end
    end
    #meal rec based on meal time
  elsif selection == 'meal time'
    puts "Which meal time do you want a suggestion for? Choose breakfast, lunch, or dinner"
    meal_time = gets.chomp
    until ["breakfast","lunch","dinner"].include?(meal_time) do
      puts "That wasn't a valid selection. Choose breakfast, lunch, or dinner"
      meal_time = gets.chomp
    end
    meal_options = user.suggest_meal_by_time
    puts "I can recommend the following meals to you:"
    meal_options.map do |option|
      "#{option.name}"
    end
  end
end

def run_command_line_interface
  welcome
  identify
  topic?
end
  # def continue_or_quit?
  #   puts "Do you want to continue or quit?"
  #   input == gets.chomp
  #   if input == "continue"
  #     topic?
  #   else
  #     exit!
  #   end
#   # end
# end
