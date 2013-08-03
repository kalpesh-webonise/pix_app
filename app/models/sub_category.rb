class SubCategory < ActiveRecord::Base
  belongs_to :category
  has_many :posts, dependent: :destroy

  validates :name, presence: true
  validates :category_id, presence: true
end
