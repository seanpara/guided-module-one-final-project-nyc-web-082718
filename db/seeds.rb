user1 = User.create
user1.name = "Peter"
user1.age = 30
user1.calorie_limit = 2000
user2 = User.create
user2.name = "Quagmire"
user2.age = 32
user2.calorie_limit = 3000
user3 = User.create
user3.name = "Joe"
user3.age = 31
user3.calorie_limit = 2500
user4 = User.create
user4.name = "Cleaveland"
user4.age = 30
user4.calorie_limit = 2000
user5 = User.create
user5.name = "Louis"
user5.age = 28
user5.calorie_limit = 1800
meal1 = Meal.create
meal1.name = "Cheez Burger"
meal1.category = "lunch dinner"
meal2 = Meal.create
meal2.name = "Omelette Du Fromage"
meal2.category = "breakfast"
meal3 = Meal.create
meal3.name = "Steak"
meal3.category = "lunch dinner"
meal4 = Meal.create
meal4.name = "Pizza"
meal4.category = "lunch"
food1 = Food.create
food1.name = "Cheez"
food1.calories = 50
food1.protein = 50
food1.fats = 50
food1.carbohydrates = 50
food1.dairy = true
food1.vegetarian = true
food1.vegan = false
food1.contains_gluten = false
food1.halal = false
food2 = Food.create
food2.name = "Tomato"
food2.calories = 10
food2.protein = 10
food2.fats = 2
food2.carbohydrates = 10
food2.dairy = false
food2.vegetarian = true
food2.vegan = true
food2.contains_gluten = false
food2.halal = true
food3 = Food.create
food3.name = "Beef"
food3.calories = 100
food3.protein = 100
food3.fats = 100
food3.carbohydrates = 10
food3.dairy = false
food3.vegetarian = false
food3.vegan = false
food3.contains_gluten = false
food3.halal = false
food4 = Food.create
food4.name = "Dough"
food4.calories = 10
food4.protein = 10
food4.fats = 10
food4.carbohydrates = 80
food4.dairy = false
food4.vegetarian = true
food4.vegan = true
food4.contains_gluten = true
food4.halal = false
food5 = Food.create
food5.name = "Chicken"
food5.calories = 25
food5.protein = 80
food5.fats = 20
food5.carbohydrates = 80
food5.dairy = false
food5.vegetarian = false
food5.vegan = false
food5.contains_gluten = false
food5.halal = true
food6 = Food.create
food6.name = "Egg"
food6.calories = 20
food6.protein = 0
food6.fats = 5
food6.carbohydrates = 70
food6.dairy = false
food6.vegetarian = true
food6.vegan = true
food6.contains_gluten = true
food6.halal = false
inventory1 = Inventory.create(user1, food1, 5)
inventory2 = Inventory.create(user1, food2, 5)
inventory3 = Inventory.create(user1, food3, 5)
inventory4 = Inventory.create(user1, food4, 5)
inventory5 = Inventory.create(user1, food5, 5)
inventory6 = Inventory.create(user1, food6, 5)
inventory7 = Inventory.create(user2, food1, 1)
inventory8 = Inventory.create(user2, food2, 2)
inventory9 = Inventory.create(user2, food3, 3)
inventory10 = Inventory.create(user2, food4, 4)
inventory11 = Inventory.create(user3, food3, 5)
inventory12 = Inventory.create(user3, food4, 4)
inventory13 = Inventory.create(user3, food5, 3)
inventory14 = Inventory.create(user3, food6, 2)
inventory15 = Inventory.create(user4, food1, 20)
inventory16 = Inventory.create(user4, food3, 20)
inventory17 = Inventory.create(user5, food1, 99)
inventory18 = Inventory.create(user5, food2, 99)
inventory19 = Inventory.create(user5, food3, 99)
inventory20 = Inventory.create(user5, food4, 99)
inventory21 = Inventory.create(user5, food5, 99)
inventory22 = Inventory.create(user5, food6, 99)
# ingredient1 = Ingredient.create(meal1, food1, 2)
ingredient1 = Ingredient.create
ingredient1 = Ingredient.meal = meal1
ingredient1 = Ingredient.food = food2
ingredient1 = Ingredient.quantity = 3
# ingredient2 = Ingredient.create(meal1, food2, 2)
ingredient2 = Ingredient.create
ingredient2 = Ingredient.meal = meal1
ingredient2 = Ingredient.food = food2
ingredient2 = Ingredient.quantity = 2
# ingredient3 = Ingredient.create(meal1, food3, 1)
ingredient3 = Ingredient.create
ingredient3 = Ingredient.meal = meal1
ingredient3 = Ingredient.food = food3
ingredient3 = Ingredient.quantity = 1
# ingredient4 = Ingredient.create(meal1, food4, 2)
ingredient4 = Ingredient.create
ingredient4 = Ingredient.meal = meal1
ingredient4 = Ingredient.food = food4
ingredient4 = Ingredient.quantity = 2
# ingredient5 = Ingredient.create(meal2, food1, 2)
ingredient5 = Ingredient.create
ingredient5 = Ingredient.meal = meal2
ingredient5 = Ingredient.food = food1
ingredient5 = Ingredient.quantity = 2
# ingredient6 = Ingredient.create(meal2, food6, 2)
ingredient6 = Ingredient.create
ingredient6 = Ingredient.meal = meal2
ingredient6 = Ingredient.food = food6
ingredient6 = Ingredient.quantity = 2
# ingredient7 = Ingredient.create(meal3, food3, 1)
ingredient7 = Ingredient.create
ingredient7 = Ingredient.meal = meal3
ingredient7 = Ingredient.food = food3
ingredient7 = Ingredient.quantity = 1
# ingredient8 = Ingredient.create(meal4, food1, 5)
ingredient8 = Ingredient.create
ingredient8 = Ingredient.meal = meal8
ingredient8 = Ingredient.food = food1
ingredient8 = Ingredient.quantity = 5
# ingredient9 = Ingredient.create(meal4, food2, 3)
ingredient9 = Ingredient.create
ingredient9 = Ingredient.meal = meal4
ingredient9 = Ingredient.food = food2
ingredient9 = Ingredient.quantity = 3
# ingredient10 = Ingredient.create(meal4, food4, 2)
ingredient10 = Ingredient.create
ingredient10 = Ingredient.meal = meal4
ingredient10 = Ingredient.food = food4
ingredient10 = Ingredient.quantity = 2
# favorite1 = Favorite.create(user1, meal1)
favorite1 = Favorite.create
favorite1.user = user1
favorite1.meal = meal1
# favorite2 = Favorite.create(user1, meal2)
favorite1 = Favorite.create
favorite1.user = user1
favorite1.meal = meal1
# favorite3 = Favorite.create(user1, meal3)
favorite2 = Favorite.create
favorite2.user = user2
favorite2.meal = meal3
# favorite4 = Favorite.create(user1, meal4)
favorite1 = Favorite.create
favorite1.user = user1
favorite1.meal = meal1
# favorite5 = Favorite.create(user2, meal1)
# favorite6 = Favorite.create(user2, meal3)
# favorite7 = Favorite.create(user3, meal2)
# favorite8 = Favorite.create(user3, meal3)
# favorite9 = Favorite.create(user4, meal1)
# favorite10 = Favorite.create(user5, meal1)
# favorite11 = Favorite.create(user5, meal4)
