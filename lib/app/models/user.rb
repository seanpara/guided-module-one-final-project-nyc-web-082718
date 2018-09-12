class User < ActiveRecord::Base
    has_many :inventories
    has_many :foods, through: :inventories
    has_many :favorites
    has_many :meals, through: :favorites


end
