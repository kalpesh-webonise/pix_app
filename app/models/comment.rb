class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, foreign_key: "post_id"
  validates :user_id, :post_id, :content, presence: true
end
