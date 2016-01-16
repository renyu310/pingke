# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!(name: "Example User",
             email: "example@test.org",
             password:
                 "111111",
             password_confirmation: "111111")
50.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@test.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password:
                   password,
               password_confirmation: password)
end




Course.create!(name: "Example Course",
             teacher: "teacher",
              introduction: "this is a introduction")
50.times do |n|
  name = Faker::Name.name
  teacher = Faker::Name.name
  introduction = "introduction"
  Course.create!(name: name,
               teacher: teacher,
               introduction: introduction
               )
end



#micropost
users = User.order(:created_at).take(6)
50.times do
content = Faker::Lorem.sentence(5)
users.each { |user| user.microposts.create!(content: content) }
end

# Following relationships
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

