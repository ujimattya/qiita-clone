# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             profile: "トライアルインターン 課題")

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  profile = "私が好きなポケモンは" + Faker::Pokemon.name + "です。"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               profile: profile)
end
# users = User.order(:created_at).take(6)
# 50.times do
#   title = Faker::Lorem.sentence(5)
#   content = Faker::Lorem.sentence(5)
#   users.each { |user| user.posts.create!(title: title,content: content) }

# end