#ActionMailer::Base.smtp_settings = {
#    :address              => "smtp.gmail.com",
#    :port                 => 587,
#    :domain               => 'mail.weboniselab.com',
#    :user_name            => 'pansingh@weboniselab.com',
#    :password             => 'pansingh6186',
#    :authentication       => 'plain',
#    :enable_starttls_auto => true
#}

ActionMailer::Base.sendmail_settings = {
    :location => '/usr/sbin/sendmail',
    :arguments => '-i -t'
}
