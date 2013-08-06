# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(first_name: "Webonise", last_name: "Lab", email: "admin@weboniselab.com", password: "pix6186", password_confirmation: "pix6186", is_admin: true) if User.count == 0
SystemSetting.create(name: "cache", value: {'category' => Time.now.utc.to_s.gsub!(/[ : +-]+/,'_'), 'sub_category' => Time.now.utc.to_s.gsub!(/[ : +-]+/,'_'), 'user' => Time.now.utc.to_s.gsub!(/[ : +-]+/,'_')}) unless SystemSetting.find_by_name("cache")
if Category.count == 0
  c1 = Category.create(name: "Real Estate")
  SubCategory.create(name: "Rent Flat/Room", category_id: c1.id)
  SubCategory.create(name: "Flatmate/Roommate", category_id: c1.id)

  c2 = Category.create(name: "Household Stuff")
  SubCategory.create(name: "Electronic Item", category_id: c2.id)
  SubCategory.create(name: "Funniture", category_id: c2.id)
  SubCategory.create(name: "Other Stuff", category_id: c2.id)

  c3 = Category.create(name: "Vehicles")
  SubCategory.create(name: "2 Wheeler", category_id: c3.id)
  SubCategory.create(name: "4 Wheeler", category_id: c3.id)
end
