
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
require "open-uri"
require 'faker'

puts "cleaning DB..."
Flat.destroy_all

puts "Creating flats..."

user1 = User.new(first_name: 'John',
                 last_name: 'Doe',
                 email: 'test@test.com',
                 password: '123456',
                 password_confirmation: '123456',)
user1.save!
puts "User 1 created !"

flats_names = ["Charming Villa", "Astonishing Manoir", "Cozy Cottage", "Elegant Estate", "Luxurious Retreat", "Modern Loft", "Spacious Bungalow", "Rustic Cabin", "Stylish Penthouse", "Sunny Beach House", "Serene Hideaway", "Enchanting Farmhouse", "Grand Chateau", "Beautiful Townhouse", "Contemporary Residence", "Chic Designer Home", "Secluded Oasis", "Welcoming Family Home", "Quaint Country House", "Exquisite Mansion", "Peaceful Getaway", "Coastal Dream House", "Bohemian Villa", "Timeless Colonial House", "Artistic Studio", "Idyllic Cottage", "Hidden Gem House", "Classic Victorian Home", "Tranquil Zen House", "Unique Dome House"]
flats_names.shuffle.each do |name|
  image = URI.open("https://source.unsplash.com/random/?house")
  flat = Flat.new(
    name: flats_name,
    price: rand(60..120),
    address: Faker::Address.full_address
  )
  flat.photo.attach(io: image, filename: 'gadjak', content_type: 'image/png')
  flat.save!
  puts "#{flat.name} has been added!"
end
