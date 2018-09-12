class Food < ActiveRecord::Base
  has_many :inventories
  has_many :users, through: :inventories
  has_many :ingredients
  has_many :meals, through: :ingredients

end
