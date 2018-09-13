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
  puts "Ask about a food."
  puts "Ask about a meal."
  puts "Ask for a meal recommmendation."
  puts "Ask for an entire day's course reccomendation."
  answer = gets.chomp

end
