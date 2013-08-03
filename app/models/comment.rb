class Comment < ActiveRecord::Base
  belongs_to :user

  validates :user_id, :post_id, :content, presence: true

end
