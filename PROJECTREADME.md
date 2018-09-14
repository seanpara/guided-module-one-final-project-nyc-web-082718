Food Recommendatron 3000

We made this project in order to help people plan out their daily meals and lead healthy lives.

It allows user to create profiles, set caloric goals, and adhere to them through recommended meals based upon a number of specifications. A more robust version of this project will provide more guidance and information than analogous platforms such as MyFitnessPal, which allow users to track their daily caloric and nutrition information but do not provide users with meal recommendations or keep track of the food items that are available_meals to them.

This project is currently in its early stages but does include a Command Line Interface that allows users to build profiles, provide information and receive meal recommendations based upon our seed data.

To use the program, first clone to repository to your local computer and enter ruby bin/run.rb from within the mail folder, then follow the instructions given.

The project was made by Chris Stull, Nicki Liu and Sean Para in the Ruby language, using Active Record to interface with sqlite3.

Main Features:

1 - Dynamic Users
  Users are created with individual names, calorie limits, and can set their own inventories to keep track of the available foods they can use to construct meals. This information is stored in the database allowing users to log back in and maintain their own records. Users can update their inventory at any time they are logged in.

2 - Food Statistics
  Foods are largely a data-heavy database object in this model and they contain all the macronutrient, caloric, and dietary restriction information. Many of the Meal class methods will parse information from the related foods in order to determine meal statistics (e.g. nutrient breakdown, gluten-free, vegetarian, etc...). Logged-in users can check specific food statistics at any time.

3 - Derived Meal Information
  Meal information is derived on-the-fly by database calls to the related Foods (joined through a table). Updating the statistics of a food will automatically update all meals for which this food is used.

4 - Dynamic Meal Suggestions
  Once users are authenticated they are able to use our CLI to find meals which match their criteria. The current search methods available are by calorie limit, time of day (e.g. breakfast), or an amount of any of the three macronutrient categories (protein, fats, carbohydrates). Users can also ask the app to recommend them a full day's meals which will select a breakfast, lunch, and dinner for them.

5 - Customizable Meals
  Meals are currently able to be created and destroyed as well as updated for name and time-of-day category.

6 - Favorites
  Users can favorite a meal and check their favorites at any time. Favorites can be added or deleted at any time for a returning user.

Reach Features:

1 - Updating Meal Ingredients
  Currently, users cannot change any meal ingredients. This also applies to new meals they create. ActiveRecord method calls would enable this for logged-in users through the CLI.

2 - Refactoring the Foods object to incorporate API data
  Foods are just hard-coded database objects at this time. Ideally, this object would be represented instead through calls to an API containing nutrition information about each Food.

3 - Additional Meal Suggestion Logic
  The ways in which our app can currently suggest meals is fairly limited. Ideally we would want further logic to allow multiple search conditions at once as well as a user being able to set their own permanent search conditions (i.e. vegetarian) and have the meals recommended reflect that choice.
