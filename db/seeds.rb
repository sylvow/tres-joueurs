# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:date
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "faker"

puts "Running the seed"

User.destroy_all

10.times do |user, index|
  user = User.new(email: Faker::Internet.email, username: "user#{index}", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, age: Faker::Date.birthday(min_age: 16, max_age: 50), phone_number: Faker::PhoneNumber.phone_number)
  user.save
end

puts "..end"