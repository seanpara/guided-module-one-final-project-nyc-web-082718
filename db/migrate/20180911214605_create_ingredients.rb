class CreateIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :ingredients do |t|
      t.integer :meal_id
      t.integer :food_id
      t.integer :quantity
    end
  end
end
