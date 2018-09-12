class AddDailyCaloriesToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :calories_consumed, :integer
  end
end
