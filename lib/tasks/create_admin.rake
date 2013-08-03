desc "Creating a admin"
  task :admin_creation => :environment do
  User.create(:first_name => "Admin",:last_name=>"Admin",:email => "admin@webonise.com",:password => "webonise6186",:password_confirmation => "webonise6186",:is_admin =>true)
end