# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180911214712) do

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "meal_id"
  end

  create_table "foods", force: :cascade do |t|
    t.string  "name"
    t.integer "calories"
    t.integer "protein"
    t.integer "fats"
    t.integer "carbohydrates"
    t.boolean "dairy"
    t.boolean "vegetarian"
    t.boolean "vegan"
    t.boolean "contains_gluten"
    t.boolean "halal"
  end

  create_table "ingredients", force: :cascade do |t|
    t.integer "meal_id"
    t.integer "food_id"
    t.integer "quantity"
  end

  create_table "inventories", force: :cascade do |t|
    t.integer "user_id"
    t.integer "food_id"
    t.integer "quantity"
  end

  create_table "meals", force: :cascade do |t|
    t.string "name"
    t.string "category"
  end

  create_table "users", force: :cascade do |t|
    t.string  "name"
    t.integer "age"
    t.integer "calorie_limit"
  end

end
