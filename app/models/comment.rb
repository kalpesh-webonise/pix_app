class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, foreign_key: "post_id"
  validates :user_id, :post_id, :content, presence: true

  def save_and_mail(user)
    post = self.post
    post_owner = post.user
    self.save
    UserMailer.delay.comment_mail(post_owner, user, post, self) if post_owner.id != user.id
  end
end
