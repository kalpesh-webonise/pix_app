class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, foreign_key: "post_id"
end
