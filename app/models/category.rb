class Category < ActiveRecord::Base
  has_many :sub_categories
  has_many :posts
end
