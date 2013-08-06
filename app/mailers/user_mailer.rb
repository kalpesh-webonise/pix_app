class UserMailer < ActionMailer::Base
  default from: "pix@weboniselab.com"

  def welcome_email(user,password)
    @password, @user = password, user
    mail(to: user.email, subject: "Registered Successfully", content_type: "text/html" )
  end

  def comment_mail(post_owner, comment_owner, post, comment)
     @post_owner, @comment_owner, @post, @comment = post_owner, comment_owner, post, comment
     mail(to: post_owner.email, subject: "Comment on Your Post", content_type: "text/html" )
  end
end
