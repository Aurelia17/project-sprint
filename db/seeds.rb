require "open-uri" # to be able to use the class URI used for fetching the flats informations

puts "cleaning DB..."
# Destroy all the users in the database to make sure we are not duplicating it
User.destroy_all
# Destroy all the flats in the database to make sure we are not duplicating it
Flat.destroy_all

# Create the user
user = User.new(
  email: 'test@test.com',
  password: '123456',
  password_confirmation: '123456'
)
# Save the user in the database
user.save!
puts "User 1 created!"

puts "Creating flats..."


url = "https://raw.githubusercontent.com/lewagon/flats-boilerplate/master/flats.json"
# Storing the informations of the Json file in a variable called flats, each object will be a flat
flats = JSON.parse(URI.open(url).read)

# repeting 5 times the folowing code
5.times do
  flats.each do |flat_data|  # Use flat_data to avoid confusion
    flat = Flat.new(
      name: flat_data['name'],
      price: flat_data['price'],
      address: "Paris, France"
    )

    image_url = flat_data['imageUrl']
    image = URI.open(image_url)
    filename = "#{rand(99..999999)}.png"
    flat.photo.attach(io: image, filename: filename, content_type: 'image/png')
    flat.save!
    puts "#{flat.name} has been created"
  end
end
