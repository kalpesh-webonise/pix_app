class Post < ActiveRecord::Base
  belongs_to :user, foreign_key: "user_id"
  has_many :comments

  validates :title, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :sub_category_id, presence: true
  validates :location, presence: true
  validates :price, presence: true
  validates :name, presence: true
  validates :contact_number, presence: true
  validates_numericality_of :price, :contact_number
end
