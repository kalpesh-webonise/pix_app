class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user,password)
    @password = password
    @user =user
    mail(:to =>user.email,:subject=>"Registered Successfully",:content_type=>"text/html" )
  end
end
