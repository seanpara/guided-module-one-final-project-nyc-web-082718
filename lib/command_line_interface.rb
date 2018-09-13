def welcome
  puts "Welcome to the food recommendatron 3000."
end

def identify
  puts "Are you a new user or a returning user?"
  puts "Please answer 'yes' or 'no'"
  new_or_not = gets.chomp

  until new_or_not == "yes" || new_or_not == "no"
    puts "That is not a valid response. Please type 'yes' or 'no' exactly as shown."
    new_or_not = gets.chomp
  end
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
  puts "To ask about a food type 'food'."
  puts "To ask about a meal type 'meal'."
  puts "For a meal recommendation type 'recommend meal'."
  puts "For an entire day's course recommendation type 'recommend course'."
  answer = gets.chomp
  case answer
  when "food"
    puts "What food do you want to ask about?"
    food = gets.chomp
    possible_foods = Food.all.map { |food| food.name }
    until possible_foods.contain?(food)
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
    food.send("#{desired_info}")

  when "meal"
    puts "What meal do you want to ask about?"
    meal = gets.chomp
    possible_meals = Meal.all.map { |meal| meal.name }
    until possible_meals.contain?(meal)
      puts "Please select a real meal."
      meal = gets.chomp
    end

    puts "What information would you like to know about #{meal}?"
    desired_info = gets.chomp
    possible_info = Meal.column_names
    until possible_info.include?(desired_info)
      puts "Please ask for legitimate information."
      desired_info = gets.chomp
    end
    meal.send("#{desired_info}")

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
    end
  when "recommend course"


  else
    puts "Please put a legitimate choice."
  end

end
