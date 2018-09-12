class Meal < ActiveRecord::Base
  has_many :ingredients
  has_many :foods, through: :ingredients
  has_many :favorites
  has_many :users, through: :favorites

end
