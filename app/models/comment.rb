class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, foreign_key: "post_id"
  validates :user_id, :post_id, :content, presence: true

  def self.recent_comments recent_comment_id, post_id
    self.where("post_id = ? AND id > ?", post_id, recent_comment_id).includes(:user).select("id, content, user_id, created_at").order("created_at DESC")
  end

  def save_and_mail(user)
    post = self.post
    post_owner = post.user
    self.save
    UserMailer.delay.comment_mail(post_owner, user, post, self) if post_owner.id != user.id
  end

end
