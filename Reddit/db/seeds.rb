# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "generating users"

louis = User.create!(username: "louis", email: "test@me.com", password: "testtest")
mandy = User.create!(username: "ilovecheese", email: "test2@me.com", password: "goudagouda")

100.times do
  begin
    name = Faker::Internet.user_name
  end while User.exists?(username: name)
  begin
    email = Faker::Internet.email
  end while User.exists?(email: email)
  User.create!(username: name, email: email, password: "testtest")
end

puts "generated #{User.count} users"

puts "generating subs"

300.times do
  user = User.offset(rand(0...User.count)).first
  begin
    title = "#{Faker::Hacker.adjective} #{Faker::StarWars.character}".titleize
  end while Sub.exists?(title: title)
  description = Faker::Hacker.say_something_smart
  Sub.create!(user_id: user.id, title: title, description: description)
end

puts "generated #{Sub.count} subs"

puts "generating posts"

900.times do
  user = User.offset(rand(0...User.count)).first
  begin
    title = "#{Faker::StarWars.specie} #{Faker::Hacker.verb} #{Faker::StarWars.character}"
  end while Post.exists?(title: title)
  url = Faker::Internet.url
  content = Faker::Hipster.sentences(3)
  Post.create!(author: user, title: title, url: url, content: content)
end

puts "generated #{Post.count} posts"

puts "associating posts with subs"

Post.all.each do |post|
  sub = Sub.offset(rand(0...Sub.count)).first
  PostSub.create!(post_id: post.id, sub_id: sub.id)
end

puts "associated #{PostSub.count} posts to subs"
