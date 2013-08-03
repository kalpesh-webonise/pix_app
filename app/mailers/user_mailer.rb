class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(email,password)
    @password = password
    mail(:to =>email,:subject=>"Registered Successfully",:content_type=>"text/html" )
  end
end
