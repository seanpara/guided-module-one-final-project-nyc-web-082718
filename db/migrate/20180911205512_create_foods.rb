class CreateFoods < ActiveRecord::Migration[5.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :calories
      t.integer :protein
      t.integer :fats
      t.integer :carbohydrates
      t.boolean :dairy
      t.boolean :vegetarian
      t.boolean :vegan
      t.boolean :contains_gluten
      t.boolean :halal

    end
  end
end
