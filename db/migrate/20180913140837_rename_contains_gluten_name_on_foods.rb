class RenameContainsGlutenNameOnFoods < ActiveRecord::Migration[5.0]
  def change
    rename_column :foods, :contains_gluten, :gluten
  end
end
