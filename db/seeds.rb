# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: 'Example User',
             email: 'example@railstutorial.org',
             password: 'foobar',
             password_confirmation: 'foobar',
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
users.each { |user| user.activities.create!(title: title, category: category) }
title = 'プログラミング全般'
category = 'プログラミング'
users.each { |user| user.activities.create!(title: title, category: category) }
title = '読書全般'
category = '読書'
users.each { |user| user.activities.create!(title: title, category: category) }
title = 'スポーツ全般'
category = 'スポーツ'
users.each { |user| user.activities.create!(title: title, category: category) }
title = '音楽全般'
category = '音楽'
users.each { |user| user.activities.create!(title: title, category: category) }
title = '芸術全般'
category = '芸術'
users.each { |user| user.activities.create!(title: title, category: category) }

# activities = Activity.order(:id).take(25)
# 3.times do
#  memo = 'memo_test'
#  activities.each { |activity| activity.microposts.create!(memo: memo) }
# end
