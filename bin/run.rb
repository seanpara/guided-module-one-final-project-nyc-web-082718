require_relative '../config/environment'
require_relative '../lib/command_line_interface.rb'
# require_relative '..lib/app/models/favorite.rb'
# require_relative '..lib/app/models/food.rb'
# require_relative '..lib/app/models/ingredient.rb'
# require_relative '..lib/app/models/inventory.rb'
# require_relative '..lib/app/models/meal.rb'
# require_relative '..lib/app/models/user.rb'

run_command_line_interface

# Sean:
# easy: I want to be able to enter a calorie amount and get a list of meals that are under that calorie level
# easy: I want to be able to add a meal i like to my favorites list as well as remove them
# easy: I should be able to prepare a meal and subtract the ingredients from my inventory
# medium : I want to be able enter my name and check which types of meals are vailable based on my inventory
# medium: I want to be able to know which ingredients I'm missing in ordered to make a specified meal
# hard: I want to be able to find all the recipes I am only missing one ingredient for

# Chris:
# easy: I want to be able to query my favorites in place of the full meals table
## easy: I want to be able to eat a meal and reduce the total daily calorie count needed
## easy: I want to be able to restrict my meal selection based on the category: time of day
## medium: I want to be able to specify a nutrient amount and get a list of meals based on that
#  |==> meal needs to be able to list its nutrients
#$ medium: I want to be able to CRUD meals
# medium/hard: I want to be able to restrict my meal selection based on dietary restrictions on the foods
# hard: I want to be given a list of meals which satisfy my daily calorie count
# |==> randomly picks a meal based on times remaining and calories remaining and adjusts calories. does this 4 times.
# |==> returns a list of the meals. Does not care about ingredients and inventories.


# as a meal i want to be able to determine my calorie count based on the foods used in me

# "https://github.com/toddmotto/public-apis#food--drink"
