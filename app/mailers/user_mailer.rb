class UserMailer < ActionMailer::Base
  default from: "pix@weboniselab.com"

  def welcome_email(user,password)
    @password = password
    @user =user
    mail(:to =>user.email,:subject=>"Registered Successfully",:content_type=>"text/html" )
  end

  def comment_mail(owner, user_name, title, content)
     @owner = owner
     @user_name = user_name
     @post_title = title
     @content = content
     mail(:to =>owner.email,:subject=>"Comment on Your Post",:content_type=>"text/html" )
  end
end
