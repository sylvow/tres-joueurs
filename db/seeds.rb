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
Game.destroy_all
Meeting.destroy_all

first_game = Game.new(name: "Tarot", description: "Jeu de carte qui se joue à 5", category: "cartes")
first_game.save!

second_game = Game.new(name: "Loup-garou", description: "Jeu de carte ou il faut deviner qui sont les loup-garous", category: "cartes")
second_game.save!

10.times do |index|

  user = User.new(email: "user#{index}@gmail.com", username: "user#{index}", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, date_of_birth: Faker::Date.birthday(min_age: 16, max_age: 50), phone_number: Faker::PhoneNumber.phone_number, password: 123456)
  user.save!

  meeting = Meeting.new(title: Faker::Game.title, 
                        description: "Description du jeu, qui est vraiment génial et c'est le jeu numéro #{index}", 
                        players_needed_min: 3, 
                        players_needed_max: 8,
                        location_type: "Bar",
                        place_name: "#{index} rue de la beuverie",
                        place_address: Faker::Address.city,
                        latitude: 48.86,
                        longitude: 2.33,
                        status: [ :available, :full, :ongoing, :cancelled, :finished ].sample,
                        level: ["Débutant", "Intermédiaire", "Expert"].sample,
                        date: DateTime.now,
                        game_id: Game.all.sample.id,
                        user_id: User.all.sample.id)
  meeting.save!
end

puts "..end"