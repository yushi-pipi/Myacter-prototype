# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: 'Guest User',
             email: 'guest@sample.jp',
             password: 'foobar',
             password_confirmation: 'foobar',
             topimage: open("#{Rails.root}/app/assets/images/pen.png"),
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(5)

title = '学習全般'
category = '学習'
users.each { |user| user.activities.create!(title: title, category: category, picture: open("#{Rails.root}/app/assets/images/pen_green.png")) }
title = 'プログラミング全般'
category = 'プログラミング'
users.each { |user| user.activities.create!(title: title, category: category, picture: open("#{Rails.root}/app/assets/images/pc.png")) }
title = '読書全般'
category = '読書'
users.each { |user| user.activities.create!(title: title, category: category, picture: open("#{Rails.root}/app/assets/images/book.png")) }
title = 'スポーツ全般'
category = 'スポーツ'
users.each { |user| user.activities.create!(title: title, category: category, picture: open("#{Rails.root}/app/assets/images/sports.png")) }
title = '音楽全般'
category = '音楽'
users.each { |user| user.activities.create!(title: title, category: category, picture: open("#{Rails.root}/app/assets/images/music.png")) }
title = '芸術全般'
category = '芸術'
users.each { |user| user.activities.create!(title: title, category: category, picture: open("#{Rails.root}/app/assets/images/paret.png")) }

# activities = Activity.order(:id).take(25)
# 3.times do
#  memo = 'memo_test'
#  activities.each { |activity| activity.microposts.create!(memo: memo) }
# end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
