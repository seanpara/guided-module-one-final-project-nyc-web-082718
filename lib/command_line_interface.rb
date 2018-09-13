def welcome
  puts "Welcome to the food recommendatron 3000."
end

def identify
  puts "Are you a new user or a returning user?"
  puts "Please answer 'yes' or 'no'"
  new_or_not = gets.chomp

  until new_or_not.downcase == "yes" || new_or_not.downcase == "no"
    puts "That is not a valid response. Please type 'yes' or 'no' exactly as shown."
    new_or_not = gets.chomp
  end
  new_or_not
end

def set_up_user
  if new_or_not == "yes"
    puts "please enter your old ID"
    id = gets.chomp
    id_valid?(id)
    puts "Welcome back #{user.name}".
  else
    user = User.create
    puts "Please enter your information."
    get_new_user_info
    puts "Your account has been successfully created. You used ID is #{user.id}. Please store it somewhere safe."
  end
end

def id_valid?(id)
  user = User.all.find { |user| user.id == id }
  if result == nil
    puts "No with that user has been found. Start over and create a new account or enter a real ID dummy."
    #need a method that restarts everything here
  end
end

def get_new_user_info
  puts "What is your name?"
  name = gets.chomp
  User.name = name
  puts "What is your age?"
  age = gets.chomp
  User.age = age
  puts "What is your daily calorie_limit?"
  calorie_limit = gets.chomp
  User.calorie_limit = calorie_limit
end

def create_inventories
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
  puts "Ask about a food."
  puts "Ask about a meal."
  puts "Ask for a meal recommmendation."
  puts "Ask for an entire day's course reccomendation."
  puts "Update your inventory."
  answer = gets.chomp
end

def meal_recommendation(user)
  puts "How do you want to pick a meal?"
  puts "Please select 'calories','macros', or 'meal time'"
  selection = gets.chomp

  until selection in ['calories','macros','meal time']
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
    until macro in ['protein','fats','carbohydrates']
      puts "That's not a valid macro. Please pick from protein, fats, or carbohydrates."
      macro = gets.chomp
    end
    puts "How many grams of #{macro} are you looking for?"
    amount = gets.chomp.to_i
    until amount.is_a? Integer
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
  elsif selection == 'meal time'
    puts "Which meal time do you want a suggestion for? Choose breakfast, lunch, or dinner"
    meal_time = gets.chomp
    until meal_time in ["breakfast","lunch","dinner"]
      puts "That wasn't a valid selection. Choose breakfast, lunch, or dinner"
      meal_time = gets.chomp
    end
    meal_options = user.suggest_meal_by_time
    puts "I can recommend the following meals to you:"
    meal_options.map do |option|
      "#{option.name}"
    end
  end
