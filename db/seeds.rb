# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require "SecureRandom"

10.times do |n|
  email = Faker::Internet.email
  password = "password"
  name = "SEED"
  User.create!(name: SecureRandom.hex(5),
               email: email,
               password: password,
               password_confirmation: password,
               uid: n + 1,
               provider: ""
               )
end


#10件の投稿データを生成
n = 1
while n <= 10
  Photo.create(
    # title: "test",
    content: "てすとじゃよ♩",
    user_id: n
  )
  n = n + 1
end
