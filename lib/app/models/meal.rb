class Meal < ActiveRecord::Base

  def initialize(argument)
    @argument = argument
  end

  def my_ingredients
    Ingredient.all.select do |ingredient|
      ingredient.meal == self
    end
  end

  def my_calories_and_quanities
    hash = {}
    ingredients = self.my_ingredients
    ingredients.each do |ingredient|
      hash[ingredient.food.calories] = ingredient.quantity
    end
    hash
  end

  def list_foods
    hash = {}
    ingredients = self.my_ingredients
    ingredients.each do |ingredient|
      hash[ingredient.food.name] = ingredient.quantity
    end
    hash
  end

  def calories
    total = 0
    food_stats = my_calories_and_quanities
    food_stats.each do |calories, quantity|
      total += calories * quantity
    end
    total
  end

  # def what_category?
  #   array = self.category.split
  #   array.join(" and ")
  #   puts "#{self.name} should be eaten for " array.join(' and ')"."
  # end


  def is_classification?(classification)
    foods = self
  end
end
